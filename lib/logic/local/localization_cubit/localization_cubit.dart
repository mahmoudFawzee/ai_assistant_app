import 'dart:developer';

import 'package:ai_assistant_app/data/key/preferences_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(const LocalizationInitialState());
  Future changeLang(String langCode) async {
    final result = await _setLang(langCode);
    if (result) {
      emit(LangChangedState(langCode));
      return;
    }
    emit(const GetLangErrorState());
  }

  void getLang() async {
    final preferences = await SharedPreferences.getInstance();
    final lang = preferences.getString(PreferencesKeys.lang);
    log('lang is : $lang');
    if (lang != null) {
      emit(GotLangState(lang));
      return;
    }
    await _setLang('en');
    emit(const GotLangState('en'));
    return;
  }

  Future<bool> _setLang(String langCode) async {
    final preferences = await SharedPreferences.getInstance();
    final result = await preferences.setString(PreferencesKeys.lang, langCode);
    return result;
  }
}
