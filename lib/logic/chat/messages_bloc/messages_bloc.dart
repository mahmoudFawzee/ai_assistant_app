import 'dart:developer';

import 'package:ai_assistant_app/data/models/ai_assistant/message.dart';
import 'package:ai_assistant_app/data/models/ai_assistant/message_spec.dart';
import 'package:ai_assistant_app/data/services/ai_assistant/messages_service.dart';
import 'package:ai_assistant_app/data/services/ai_assistant/ai_assistant_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  //?this the list which hold all data.
  final List<Message> _messagesList = [];
  //?var for storing the total amount of messages in the conversation
  int _dbRowLength = 0;
  //?var for storing number of messages pages.
  int _numberOfPages = 0;
  //?var for storing the current page.
  int _currentPage = 1;
  //?var for set the start point we will get rows from.
  int _offset = 0;
  //?var for set the maximum rows per page (request) .
  static const int _limit = 10;

//*********************************************************************
//methods :
  bool reloadPagination() {
    logData();
    //?we reach end of conversation messages.
    if (_currentPage >= _numberOfPages) return false;
    //!we start with id 1 so we need to make it starts with 1.
    final offset = _currentPage * _limit;
    if (_currentPage < _numberOfPages) {
      //todo: get data.
      //todo: add data to the messages list.

      _offset = offset;
      _currentPage++;
    }
    logData();
    return true;
  }

  void resetData() {
    log('pagination data reset data');
    _messagesList.clear();
    _dbRowLength = 0;
    _numberOfPages = 0;
    _currentPage = 1;
    _offset = 0;
  }

  logData() {
    log(' pagination data :  length : $_dbRowLength  current page : $_currentPage  n of pages : $_numberOfPages');
    log('load more : result offset : $_offset');
  }

  MessagesBloc() : super(const MessagesInitialState()) {
    final messageService = MessagesService();

    final aiAssistantService = AiAssistantService();

    on<OpenConversationMessagePageEvent>((event, emit) async {
      emit(const MessagesLoadingState());
      try {
        final nOfMessages = await messageService.getNumberOfMessages(
          event.conversationId,
        );
        if (nOfMessages == 0) {
          emit(const NoMessagesState());
          return;
        }
        //?the problem is here we call the constructor each time we
        //?call the event.
        //?find solution for that.
        _dbRowLength = nOfMessages;
        _numberOfPages = (_dbRowLength / _limit).ceil();
        final result = await messageService.getRangeMessages(
          event.conversationId,
          //?in the first request offset is 0
          offset: _offset,
          limit: _limit,
        );
        _messagesList.addAll(result);
        log('build state : messages : ${_messagesList.length}');
        emit(GotConversationMessagesState(
          messages: _messagesList,
        ));
        return;
      } catch (e) {
        emit(MessagesErrorState(e.toString()));
      }
    });

    on<LoadMoreMessagesEvent>((event, emit) async {
      log('start load more messages');
      final reloaded = reloadPagination();
      if (!reloaded) return;
      emit(const NewMessagesLoadingState());
      try {
        final result = await messageService.getRangeMessages(
          event.conversationId,
          offset: _offset,
          limit: _limit,
        );
        log('load more : result ${result.length} ');
        _messagesList.addAll(result);
        emit(GotConversationMessagesState(
          messages: _messagesList,
        ));
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
        final messageSpec = MessageSpec(
          isMe: true,
          title: event.title,
          conversationId: event.conversationId,
          date: DateTime.now().toString(),
        );
        final userMessageId =
            await messageService.storeMessageLocally(messageSpec);
        //?if the message didn't store, stop whole process.
        if (userMessageId == 0) return;
        //todo: here we need to get the last 10 messages
        //todo: which includes the last message which is
        //todo: user message.
        final message = await messageService.getMessage(
          conversationId: messageSpec.conversationId,
          messageId: userMessageId,
        );
        //?this message will be the last one so
        //?we want to store it in the first index.
        _messagesList.insert(0, message);
        emit(GotConversationMessagesState(messages: _messagesList));
        emit(const AiGettingResponseState());

        final aiRes = await aiAssistantService.getAIResponse(messageSpec.title);

        final aiMessage = MessageSpec(
          isMe: false,
          title: aiRes,
          date: DateTime.now().toString(),
          conversationId: messageSpec.conversationId,
        );
        final aiMessageId = await messageService.storeMessageLocally(aiMessage);
        final message2 = await messageService.getMessage(
          conversationId: aiMessage.conversationId,
          messageId: aiMessageId,
        );
        //?this message will be the last one so
        //?we want to store it in the first index.
        _messagesList.insert(0, message2);

        emit(GotConversationMessagesState(messages: _messagesList));
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

    on<CloseMessagesScreenEvent>((event, emit) async {
      resetData();
    });
  }
}
