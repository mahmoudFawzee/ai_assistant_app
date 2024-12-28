import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:ai_assistant_app/data/services/conversation_service.dart';
import 'package:ai_assistant_app/data/models/conversation.dart';
part 'conversation_state.dart';

class ConversationCubit extends Cubit<ConversationState> {
  ConversationCubit() : super(const ConversationInitial());
  final _conversationService = ConversationService();
  void getConversations() async {
    try {
      emit(const ConversationLoadingState());
      final result = await _conversationService.getConversations();
      if (result.isEmpty) {
        emit(const NoConversationState());
        return;
      }
      emit(GotConversationsState(result));
      return;
    } catch (e) {
      emit(ConversationErrorState(e.toString()));
    }
  }

  Future startNewConversation(String title) async {
    try {
      final Conversation conversation = Conversation(id: 0, title: title);
      final id = await _conversationService.startNewConversation(conversation);
      if (id == 0) {
        emit(const ConversationCreationErrorState(
            'conversation creation error'));
        return;
      }
      await _conversationService.createConversationMessagesTable(id);
      emit(ConversationCreatedState(id));
      return;
    } catch (e) {
      emit(ConversationErrorState(e.toString()));
    }
  }

  Future updateConversation({
    required int oldId,
    required Conversation conversation,
  }) async {
    try {
      emit(const ConversationLoadingState());
      final id = await _conversationService.updateConversation(
        oldId: oldId,
        conversation: conversation,
      );
      if (id == 0) {
        emit(const ConversationUpdatingErrorState(
            'conversation updating error'));
        return;
      }
      emit(ConversationUpdatedState(id));
    } catch (e) {
      emit(ConversationErrorState(e.toString()));
    }
  }

  Future deleteConversation(int id) async {
    try {
      emit(const ConversationLoadingState());
      final result = await _conversationService.deleteConversation(id);
      if (result == id) {
        emit(const ConversationDeletedState());
        return;
      }
      emit(const ConversationDeletingErrorState('conversation deleting error'));
      return;
    } catch (e) {
      emit(ConversationErrorState(e.toString()));
    }
  }
}
