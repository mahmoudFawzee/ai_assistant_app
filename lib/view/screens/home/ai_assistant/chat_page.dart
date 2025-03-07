import 'dart:developer';

import 'package:ai_assistant_app/data/models/ai_assistant/message.dart';
import 'package:ai_assistant_app/logic/chat/conversation_cubit/conversation_cubit.dart';
import 'package:ai_assistant_app/logic/chat/messages_bloc/messages_bloc.dart';
import 'package:ai_assistant_app/logic/chat/mic_cubit/mic_cubit.dart';
import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:ai_assistant_app/view/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.conversationId,
    required this.conversationTitle,
  });
  static const pageRoute = '/chat_screen';
  final int conversationId;
  final String conversationTitle;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  static final _controller = TextEditingController();
  final _scrollController = ScrollController();
  double _savedScrollOffset = 0.0;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final loadMorePoint = _scrollController.position.maxScrollExtent;

    if (_scrollController.offset >= loadMorePoint - 1) {
      _savedScrollOffset = _scrollController.offset;
      log('scroll offset : $_savedScrollOffset');
      context.read<MessagesBloc>().add(
            LoadMoreMessagesEvent(
              widget.conversationId,
            ),
          );
    }
  }

  void _sendMessage({
    required String title,
  }) {
    context.read<MessagesBloc>().add(
          SendUserMessageEvent(
            conversationId: widget.conversationId,
            title: title,
          ),
        );
    _controller.clear();
  }

  void _handleUserVoice() {
    log('handle voice');
  }

  void _startListen() {
    log('user start talking');
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

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
          title: Text(widget.conversationTitle),
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
                    if (current is AiGettingResponseState) return false;
                    if (current is NewMessagesLoadingState &&
                        previous is GotConversationMessagesState) {
                      return false;
                    }
                    if (current is MessagesLoadingState &&
                        previous is GotConversationMessagesState) {
                      return false;
                    }
                    if (current is MessagesLoadingState &&
                        previous is MessagesInitialState) {
                      return false;
                    }
                    return true;
                  },
                  builder: (context, state) {
                    log('build state :  state : $state');
                    if (state is GotConversationMessagesState) {
                      final messages = state.messages;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _scrollController.jumpTo(_savedScrollOffset);
                      });

                      return ListView.builder(
                        controller: _scrollController,
                        reverse: true,
                        itemBuilder: (context, index) {
                          final Message message = messages[index];
                          return ChatBubble(
                            key: ValueKey(index),
                            messageSpec: message.messageSpec,
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
                return BlocProvider<MicCubit>(
                  create: (context) => MicCubit(),
                  child: Builder(builder: (context) {
                    return BlocBuilder<MicCubit, TextFieldIcon>(
                      builder: (context, textFieldState) {
                        //?if we record now
                        //?disable the text field
                        //?and show tap to send.
                        final enabled = textFieldState != TextFieldIcon.wave;
                        return InkWell(
                          onTap: () {
                            if (!enabled) {
                              //todo: handle the case of
                              //todo: handling the voice to text.
                              context.read<MicCubit>().showMic();
                              _handleUserVoice();
                              return;
                            }
                          },
                          child: TextField(
                            controller: _controller,
                            enabled: enabled,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                context.read<MicCubit>().showSend();
                                return;
                              }
                              context.read<MicCubit>().showMic();
                              return;
                            },
                            decoration: InputDecoration(
                              hintText: getTextFieldHint(enabled),
                              suffixIcon: BlocBuilder<MicCubit, TextFieldIcon>(
                                builder: (context, iconState) {
                                  return IconButton(
                                    icon: Icon(
                                      //?this method will get the suitable icon.
                                      getTextFieldIcon(iconState),
                                      color: ColorsManger.blue,
                                    ),
                                    onPressed: () {
                                      if (iconState == TextFieldIcon.mic) {
                                        //todo: handle the case of
                                        //todo: start listen to voice.
                                        context.read<MicCubit>().showWave();
                                        _startListen();
                                        return;
                                      }
                                      _sendMessage(
                                        title: _controller.value.text,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  IconData getTextFieldIcon(TextFieldIcon iconState) =>
      iconState == TextFieldIcon.mic
          ? Icons.mic
          : iconState == TextFieldIcon.wave
              ? Icons.waves
              : Icons.send;

  String getTextFieldHint(bool enabled) => enabled
      ? AppLocalizations.of(context)!.askAiAnyThing
      : AppLocalizations.of(context)!.tapToSend;
}
