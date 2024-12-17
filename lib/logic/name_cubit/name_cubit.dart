import 'package:ai_assistant_app/data/key/preferences_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NameCubit extends Cubit<String> {
  NameCubit() : super('AI Assistant');
  void getName() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(PreferencesKeys.assistantName);
    if (name == null) {
      emit('AI assistant');
      return;
    }
    emit(name);
    return;
  }

  void setName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(PreferencesKeys.assistantName, name);
    getName();
  }
}
