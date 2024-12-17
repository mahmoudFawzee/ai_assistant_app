part of 'chat_history_bloc.dart';

sealed class ChatHistoryEvent extends Equatable {
  const ChatHistoryEvent();

  @override
  List<Object> get props => [];
}

final class GetHistoryMessages extends ChatHistoryEvent {
  const GetHistoryMessages();
}
