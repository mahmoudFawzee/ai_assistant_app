part of 'messages_bloc.dart';

sealed class MessagesEvent extends Equatable {
  const MessagesEvent();

  @override
  List<Object> get props => [];
}

final class GetConversationMessagesEvent extends MessagesEvent {
  final int conversationId;
  const GetConversationMessagesEvent(this.conversationId);
  @override
  List<Object> get props => [conversationId];
}

//?here we've 2 cases
//?first from user which is the text typed in the text box.
//?the other one is : from the api (the api response).

//?hint : we don't need to make event for the ai response
//?we will store it directly after the api response.
final class SendUserMessageEvent extends MessagesEvent {
  final Message message;
  const SendUserMessageEvent(this.message);
  @override
  List<Object> get props => [message];
}

final class LoadMoreMessagesEvent extends MessagesEvent {
  final int conversationId;
  const LoadMoreMessagesEvent(this.conversationId);
  @override
  List<Object> get props => [conversationId];
}

final class OpenMessagesScreenEvent extends MessagesEvent {
  final MessagesEvent messageEvent;
  const OpenMessagesScreenEvent(this.messageEvent);
  @override
  List<Object> get props => [messageEvent];
}

final class CloseMessagesScreenEvent extends MessagesEvent {
  const CloseMessagesScreenEvent();
}

final class DeleteMessageEvent extends MessagesEvent {
  final int id;
  const DeleteMessageEvent(this.id);
  @override
  List<Object> get props => [id];
}

final class ClearConversationMessagesEvent extends MessagesEvent {
  final int conversationId;
  const ClearConversationMessagesEvent(this.conversationId);
  @override
  List<Object> get props => [conversationId];
}
