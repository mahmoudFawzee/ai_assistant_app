import 'package:ai_assistant_app/logic/chat/conversation_cubit/conversation_cubit.dart';
import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:ai_assistant_app/view/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.conversationId});
  static const pageRoute = '/chat_screen';
  final int conversationId;
  static final _controller = TextEditingController();
  void _startListening() {}
  void _handleUserInput(String text) {}
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (popped, obj) {
        context.read<ConversationCubit>().getConversations();
      },
      child: Scaffold(
        
        body: Column(
          children: [
            Expanded(
                flex: 6,
                child: ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ChatBubble(
                      isMe: index % 2 == 0,
                      message: index != 0
                          ? 'message'
                          : 'This project will integrate AI capabilities into a Flutter app,providing conversational functionality and useful features like reminders and weather updates.',
                    );
                  },
                  itemCount: 15,
                )),
            const Divider(
              color: ColorsManger.black,
              height: 0,
            ),
            TextField(
              controller: _controller,
              onSubmitted: (text) => _handleUserInput(text),
              decoration: InputDecoration(
                hintText: 'Ask me anything...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.mic),
                  onPressed: _startListening,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
