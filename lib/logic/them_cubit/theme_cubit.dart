import 'package:ai_assistant_app/data/key/preferences_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<bool?> {
  ThemeCubit() : super(null);
  void changeTheme() async {
    final isDark = await _isDark();
    if (isDark == null) {
      await _setDark(dark: false);
      emit(false);
      return;
    }
    if (isDark) {
      await _setDark(dark: false);
      emit(false);
      return;
    }
    await _setDark(dark: true);
    emit(true);
    return;
  }

<<<<<<< HEAD
=======
  void getTheme() async {
    //?in this line if no stored theme we will set it here and also store it.
    final isDark = await _isDark();
    emit(isDark == true);
    return;
  }

>>>>>>> b54be31 (work on ui)
  Future<bool?> _isDark() async {
    final preferences = await SharedPreferences.getInstance();
    final currentTheme = preferences.getBool(PreferencesKeys.isDark);
    if (currentTheme == null) {
      await preferences.setBool(PreferencesKeys.isDark, true);
      return true;
    }
    return currentTheme;
  }

  Future _setDark({required bool dark}) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(PreferencesKeys.isDark, dark);
  }
}
