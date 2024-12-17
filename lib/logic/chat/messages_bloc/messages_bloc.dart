import 'package:ai_assistant_app/data/models/message.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  MessagesBloc() : super(const MessagesInitialState()) {
    on<GetMessagesEvent>((event, emit) {});
  }
}
