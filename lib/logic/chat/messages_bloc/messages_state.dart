part of 'messages_bloc.dart';

sealed class MessagesState extends Equatable {
  const MessagesState();

  @override
  List<Object> get props => [];
}

final class MessagesInitialState extends MessagesState {
  const MessagesInitialState();
}

final class MessagesLoadingState extends MessagesState {
  const MessagesLoadingState();
}

final class MessagesStoredState extends MessagesState {
  const MessagesStoredState();
}

final class GotConversationMessagesState extends MessagesState {
  final List<Message> messages;
  const GotConversationMessagesState(this.messages);
  @override
  List<Object> get props => [messages];
}
final class UserMessageStoredLocallyState extends MessagesState {
  final Message message;
  const UserMessageStoredLocallyState(this.message);
  @override
  List<Object> get props => [message];
}

final class GotAiAssistantResponseState extends MessagesState {
  final Message message;
  const GotAiAssistantResponseState(this.message);
  @override
  List<Object> get props => [message];
}

final class NoMessagesState extends MessagesState {
  const NoMessagesState();
}

final class MessagesErrorState extends MessagesState {
  final String error;
  const MessagesErrorState(this.error);
  @override
  List<Object> get props => [error];
}

final class ConversationMessageClearedState extends MessagesState {
  const ConversationMessageClearedState();
}
