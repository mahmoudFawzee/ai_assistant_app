part of 'conversation_cubit.dart';

@immutable
sealed class ConversationState extends Equatable {
  const ConversationState();
  @override
  List<Object?> get props => [];
}

final class ConversationInitial extends ConversationState {
  const ConversationInitial();
}

final class NoConversationState extends ConversationState {
  const NoConversationState();
}

final class ConversationErrorState extends ConversationState {
  final String error;
  const ConversationErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
final class GotConversationsState extends ConversationState {
  final List<Conversation> conversations;
  const GotConversationsState(this.conversations);
  @override
  List<Object?> get props => [conversations];
}
