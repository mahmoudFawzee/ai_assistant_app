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
    //?those tow vars will be used with the load more messages event.
    int? lastLoadedId;

    on<LoadMoreMessagesEvent>((event, emit) async {
      //emit(const MessagesLoadingState());

      try {
        final loadedMessages = await messageService.getRangeMessages(
          event.conversationId,
          start: lastLoadedId! - 20,
          end: lastLoadedId!,
        );
        lastLoadedId = lastLoadedId! - 20;
        emit(GotConversationMessagesState(loadedMessages));
      } catch (e) {
        emit(MessagesErrorState(e.toString()));
      }
    });

    on<GetConversationMessagesEvent>((event, emit) async {
      emit(const MessagesLoadingState());
      try {
        final lastMessageId = await messageService.getLastMessageId(
          event.conversationId,
        );
        if (lastMessageId == null) {
          emit(const NoMessagesState());
          return;
        }
        lastLoadedId = lastMessageId;
        final result = await messageService.getRangeMessages(
          event.conversationId,
          start: lastLoadedId! - 20,
          end: lastLoadedId!,
        );

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
        final userMessageId =
            await messageService.storeMessageLocally(event.message);
        //?if the message didn't store, stop whole process.
        if (userMessageId == 0) return;
        //todo: here we need to get the last 10 messages
        //todo: which includes the last message which is
        //todo: user message.
        final messages = await messageService.getRangeMessages(
          event.message.conversationId,
          start: userMessageId - 20,
          end: userMessageId,
        );
        lastLoadedId = userMessageId - 20;
        emit(GotConversationMessagesState(messages));
        final aiRes =
            await aiAssistantService.getAIResponse(event.message.title);
        final aiMessage = Message(
          isMe: false,
          title: aiRes,
          id: 0,
          date: '${DateTime.now()}',
          time: '${TimeOfDay.now()}',
          conversationId: event.message.conversationId,
        );
        final aiMessageId = await messageService.storeMessageLocally(aiMessage);
        final messages2 = await messageService.getRangeMessages(
          event.message.conversationId,
          start: aiMessageId - 20,
          end: aiMessageId,
        );
        lastLoadedId = aiMessageId - 20;
        emit(GotConversationMessagesState(messages2));
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
