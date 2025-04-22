import 'package:ai_assistant_app/data/repos/settings_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsInitial());
  void resetSettings() async {
    final rested = await SettingsRepo.resetSettings();
    if (rested) {
      emit(const ResetSettingsState());
      return;
    }
  }
}
