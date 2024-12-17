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

final class ConversationCreationState extends ConversationState {
  final int id;
  const ConversationCreationState(this.id);
  @override
  List<Object?> get props => [id];
}

final class ConversationUpdatedState extends ConversationState {
  final int id;
  const ConversationUpdatedState(this.id);
  @override
  List<Object?> get props => [id];
}

final class ConversationErrorState extends ConversationState {
  final String error;
  const ConversationErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

final class ConversationCreationErrorState extends ConversationState {
  final String error;
  const ConversationCreationErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

final class ConversationUpdatingErrorState extends ConversationState {
  final String error;
  const ConversationUpdatingErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
final class ConversationDeletingErrorState extends ConversationState {
  final String error;
  const ConversationDeletingErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

final class GotConversationsState extends ConversationState {
  final List<Conversation> conversations;
  const GotConversationsState(this.conversations);
  @override
  List<Object?> get props => [conversations];
}
final class ConversationDeletedState extends ConversationState {
  
  const ConversationDeletedState();
  
}
