import 'package:ai_assistant_app/logic/name_cubit/name_cubit.dart';
<<<<<<< HEAD
=======
import 'package:ai_assistant_app/view/theme/color_manger.dart';
>>>>>>> b54be31 (work on ui)
import 'package:ai_assistant_app/view/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  static const pageRoute = '/chat_screen';
  static final _controller = TextEditingController();
  void _startListening() {}
  void _handleUserInput(String text) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
=======
        centerTitle: true,
>>>>>>> b54be31 (work on ui)
        title: BlocBuilder<NameCubit, String>(
          builder: (context, state) {
            return Text(state);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
<<<<<<< HEAD
              child: ListView.builder(
            itemBuilder: (context, index) {
              return const ChatBubble(message: 'message',);
            },
            itemCount: 15,
          )),
=======
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
>>>>>>> b54be31 (work on ui)
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
    );
  }
}
