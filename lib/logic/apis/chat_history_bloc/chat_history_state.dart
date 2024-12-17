part of 'chat_history_bloc.dart';

sealed class ChatHistoryState extends Equatable {
  const ChatHistoryState();

  @override
  List<Object> get props => [];
}

final class ChatHistoryInitial extends ChatHistoryState {
  const ChatHistoryInitial();
}

final class GotHistoryState extends ChatHistoryState {
  final List<Message> messages;
  const GotHistoryState(this.messages);
  @override
  List<Object> get props => [messages];
}
