import 'package:ai_assistant_app/view/screens/home/chat_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConversationsScreen extends StatelessWidget {
  const ConversationsScreen({super.key});
  static const pageRoute = '/conversations_screen';

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title:  Text(appLocalizations.conversations),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            //context.go(ChatScreen.pageRoute);
            context.push(ChatScreen.pageRoute);
          },
          child: const Text(
            'go to chat',
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
