import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeMessageCubit extends Cubit<String> {
  WelcomeMessageCubit() : super('');
  void getWelcomeMessage(BuildContext context) =>
      emit(_getMessage(context));
  String _getMessage(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    final hour = DateTime.now().hour;
    if (hour < 9) return appLocalizations.morning; //[0:9]
    if (hour < 17) return appLocalizations.afternoon; //[9:17]
    return appLocalizations.evening; //[17:23]
  }
}
