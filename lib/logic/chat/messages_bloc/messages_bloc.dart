import 'package:ai_assistant_app/data/models/message.dart';
import 'package:ai_assistant_app/data/services/messages_service.dart';
import 'package:ai_assistant_app/data/services/ai_assistant_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  MessagesBloc() : super(const MessagesInitialState()) {
    final messageService = MessagesService();
    final aiAssistantService = AiAssistantService();
    on<GetConversationMessagesEvent>((event, emit) async {
      emit(const MessagesLoadingState());
      try {
        final result =
            await messageService.getConversationMessages(event.conversationId);
        if (result.isEmpty) {
          emit(const NoMessagesState());
          return;
        }
        emit(GotConversationMessagesState(result));
        return;
      } catch (e) {
        emit(MessagesErrorState(e.toString()));
      }
    });

    //todo: send message.
    //todo: store user message
    //todo: emit user message sent with the message stored to
    //display it on the chat page.
    //todo: send api request
    //todo: store the assistant message
    //todo: emit ai assistant response with the message

    on<SendUserMessageEvent>((event, emit) async {
      emit(const MessagesLoadingState());
      try {
        final message = await messageService.storeMessageLocally(event.message);
        emit(UserMessageStoredLocallyState(message));
        final aiRes = await aiAssistantService.getAIResponse(message.title);
        final aiMessage = Message(
          isMe: false,
          title: aiRes,
          id: 0,
          date: '${DateTime.now()}',
          time: '${TimeOfDay.now()}',
          conversationId: event.message.conversationId,
        );
        final aiStoredMessage =
            await messageService.storeMessageLocally(aiMessage);
        emit(GotAiAssistantResponseState(aiStoredMessage));
      } catch (e) {
        emit(MessagesErrorState(e.toString()));
      }
    });

    on<ClearConversationMessagesEvent>((event, emit) async {
      emit(const MessagesLoadingState());
      try {
        final result = await messageService
            .deleteConversationMessages(event.conversationId);
        if (result > 0) {
          emit(const ConversationMessageClearedState());
          return;
        }
        emit(const MessagesErrorState('conversation had not been cleared'));
        return;
      } catch (e) {
        emit(MessagesErrorState(e.toString()));
      }
    });
  }
}
