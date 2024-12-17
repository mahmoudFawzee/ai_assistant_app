import 'package:ai_assistant_app/data/models/message.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_history_event.dart';
part 'chat_history_state.dart';

class ChatHistoryBloc extends Bloc<ChatHistoryEvent, ChatHistoryState> {
  ChatHistoryBloc() : super(const ChatHistoryInitial()) {
    on<GetHistoryMessages>((event, emit) {
      
    });
  }
}
