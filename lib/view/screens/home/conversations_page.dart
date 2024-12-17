import 'package:ai_assistant_app/view/screens/home/chat_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class ConversationsScreen extends StatelessWidget {
  const ConversationsScreen({super.key});
  static const pageRoute = '/conversations_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('conversations'),
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
    );
  }
}
