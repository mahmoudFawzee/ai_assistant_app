import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeMessageCubit extends Cubit<String> {
  WelcomeMessageCubit() : super('');
  void getWelcomeMessage(BuildContext context) {
    log('start get the hour');
    emit(_getMessage(context));
  }

  String _getMessage(BuildContext context) {
    log('start get the hour2');
    final appLocalizations = AppLocalizations.of(context)!;
    log('start get the hour3');
    final hour = DateTime.now().hour;
    log('houre : $hour ');
    if (hour < 9) return appLocalizations.morning; //[0:9]
    if (hour < 17) return appLocalizations.afternoon; //[9:17]
    return appLocalizations.evening; //[17:23]
  }
}
