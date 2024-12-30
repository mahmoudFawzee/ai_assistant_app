import 'dart:developer';

import 'package:ai_assistant_app/data/models/message.dart';
import 'package:ai_assistant_app/logic/chat/conversation_cubit/conversation_cubit.dart';
import 'package:ai_assistant_app/logic/chat/messages_bloc/messages_bloc.dart';
import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:ai_assistant_app/view/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.conversationId});
  static const pageRoute = '/chat_screen';
  final int conversationId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  static final _controller = TextEditingController();
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final loadMorePoint = _scrollController.position.maxScrollExtent;

    if (_scrollController.offset >= loadMorePoint - 1) {
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

  void _sendMessage(Message message) {
    context.read<MessagesBloc>().add(SendUserMessageEvent(
          message,
        ));
    _controller.clear();
  }

  void _handleUserInput(String text) {}

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return PopScope(
      onPopInvokedWithResult: (popped, obj) {
        context.read<MessagesBloc>().add(const CloseMessagesScreenEvent());
        context.read<ConversationCubit>().getConversations();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.conversationId}'),
        ),
        body: Column(
          children: [
            const Divider(
              color: ColorsManger.black,
              height: 0,
            ),
            BlocBuilder<MessagesBloc, MessagesState>(
              builder: (context, state) {
                if (state is NewMessagesLoadingState) {
                  return const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: ColorsManger.aiMessageColor,
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
            Expanded(
                flex: 6,
                child: BlocBuilder<MessagesBloc, MessagesState>(
                  buildWhen: (previous, current) {
                    return current is! AiGettingResponseState ||
                        current is! NewMessagesLoadingState;
                  },
                  builder: (context, state) {
                    log('mes state : $state');
                    if (state is GotConversationMessagesState) {
                      final reverse = state.reverseListView;
                      final messages = state.messages;

                      return ListView.builder(
                        controller: _scrollController,
                        reverse: reverse,
                        itemBuilder: (context, index) {
                          final Message message = messages[index];
                          log('current message : ${message.title} and index : $index');

                          return ChatBubble(
                            message: message,
                          );
                        },
                        itemCount: messages.length,
                      );
                    }

                    if (state is MessagesLoadingState) {
                      return const Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator.adaptive(
                            backgroundColor: ColorsManger.myMessageColor,
                          ),
                        ),
                      );
                    }
                    if (state is NoMessagesState) {
                      return Center(
                        child: Text(appLocalization.noMessages),
                      );
                    }
                    if (state is MessagesErrorState) {
                      return Center(
                        child: Text(state.error),
                      );
                    }
                    return Container();
                  },
                )),
            const Divider(
              color: ColorsManger.black,
              height: 0,
            ),
            BlocBuilder<MessagesBloc, MessagesState>(
              builder: (context, state) {
                if (state is AiGettingResponseState) {
                  return Text(appLocalization.aiGetRes);
                }
                return TextField(
                  controller: _controller,
                  onSubmitted: (text) => _handleUserInput(text),
                  decoration: InputDecoration(
                    hintText: 'Ask me anything...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        final Message message = Message(
                          isMe: true,
                          title: _controller.value.text,
                          id: 0,
                          date: '',
                          conversationId: widget.conversationId,
                        );
                        _sendMessage(message);
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
