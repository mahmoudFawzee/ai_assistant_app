import 'package:flutter_bloc/flutter_bloc.dart';

class MicCubit extends Cubit<TextFieldIcon> {
  MicCubit() : super(TextFieldIcon.mic);
  void showMic() => emit(TextFieldIcon.mic);
  void showWave() => emit(TextFieldIcon.wave);
  void showSend() => emit(TextFieldIcon.send);
}

enum TextFieldIcon {
  mic,
  wave,
  send,
}
