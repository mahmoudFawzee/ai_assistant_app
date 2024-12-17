import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'open_ai_event.dart';
part 'open_ai_state.dart';

class OpenAiBloc extends Bloc<OpenAiEvent, OpenAiState> {
  OpenAiBloc() : super(OpenAiInitial()) {
    on<OpenAiEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
