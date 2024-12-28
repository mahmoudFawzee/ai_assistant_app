import 'package:ai_assistant_app/data/models/message.dart';
import 'package:ai_assistant_app/logic/chat/conversation_cubit/conversation_cubit.dart';
import 'package:ai_assistant_app/logic/chat/messages_bloc/messages_bloc.dart';
import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:ai_assistant_app/view/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.conversationId});
  static const pageRoute = '/chat_screen';
  final int conversationId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  static final _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (_scrollController.offset <= 0) {
      context.read<MessagesBloc>().add(
            LoadMoreMessagesEvent(
              widget.conversationId,
            ),
          );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
                child: BlocBuilder<MessagesBloc, MessagesState>(
                  builder: (context, state) {
                    if (state is GotConversationMessagesState) {
                      final messages = state.messages;
                      return ListView.builder(
                        controller: _scrollController,
                        reverse: true,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final Message message = messages[index];
                          return ChatBubble(
                            message: message,
                          );
                        },
                        itemCount: messages.length,
                      );
                    }
                    if (state is MessagesLoadingState) {
                      return const CircularProgressIndicator.adaptive(
                        backgroundColor: ColorsManger.myMessageColor,
                      );
                    }
                    if (state is NoMessagesState) {
                      return const Center(
                        child: Text('no messages here'),
                      );
                    }
                    return Container();
                  },
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
