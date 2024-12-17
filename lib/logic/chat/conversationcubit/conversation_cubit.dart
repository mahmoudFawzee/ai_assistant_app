import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:ai_assistant_app/data/services/conversation_service.dart';
import 'package:ai_assistant_app/data/models/conversation.dart';
part 'conversation_state.dart';

class ConversationCubit extends Cubit<ConversationState> {
  ConversationCubit() : super(const ConversationInitial());
  final _conversationService = ConversationService();
  Future getConversation() async {
    try {
      final result = await _conversationService.getConversation();
      if (result.isEmpty) {
        emit(const NoConversationState());
        return;
      }
      emit(GotConversationsState(result));
    } catch (e) {
      emit(ConversationErrorState(e.toString()));
    }
  }
}
