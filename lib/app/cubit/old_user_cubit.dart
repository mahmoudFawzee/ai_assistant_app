import 'package:ai_assistant_app/data/repos/settings_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OldUserCubit extends Cubit<bool> {
  OldUserCubit() : super(true);

  void isOldUser() async => emit(await SettingsRepo.isOldUser());
}
