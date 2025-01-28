import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});
  static const pageRoute = '/new_task_page';

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManger.white,
        elevation: 0.0,
        title: Text(
          appLocalizations.newTask,
          style:const TextStyle(fontSize: 20),
        ),
      ),
      body:const Column(
        children: [
          //?we need title of the task
          //?then we need to add the date and time of it
          //?then we need to add its category
          //?then we need a small description for it (optional)
        ],
      ),
    );
  }
}
