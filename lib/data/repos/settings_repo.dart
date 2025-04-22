import 'package:ai_assistant_app/data/key/preferences_keys.dart';
import 'package:ai_assistant_app/data/services/shared_preferences_service.dart';

final class SettingsRepo {
  //i need to set theme

  //i need to set language
  //i need to set if its first visit
  static Future<bool> _oldUser() async =>
      await SharedPreferencesService.instance.setBool(
        PreferencesKeys.oldUser,
        true,
      );

  static Future<bool> isOldUser() async {
    final oldUser = await SharedPreferencesService.instance.getBool(
      PreferencesKeys.oldUser,
    );
    if (!oldUser) await _oldUser();
    return oldUser;
  }

  //i need to set user name
}
