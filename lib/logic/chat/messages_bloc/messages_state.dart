part of 'messages_bloc.dart';

sealed class MessagesState extends Equatable {
  const MessagesState();

  @override
  List<Object> get props => [];
}

final class MessagesInitialState extends MessagesState {
  const MessagesInitialState();
}

final class GotMessagesState extends MessagesState {
  final List<Message> messages;
  const GotMessagesState(this.messages);
  @override
  List<Object> get props => [messages];
}
