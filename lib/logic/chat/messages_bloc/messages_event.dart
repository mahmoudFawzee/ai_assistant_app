part of 'messages_bloc.dart';

sealed class MessagesEvent extends Equatable {
  const MessagesEvent();

  @override
  List<Object> get props => [];
}

final class GetMessagesEvent extends MessagesEvent {
  const GetMessagesEvent();
}
