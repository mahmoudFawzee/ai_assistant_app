import 'dart:developer';
import 'package:ai_assistant_app/view/screens/home/ai_assistant/conversations/conversation_cubit/conversation_cubit.dart';
import 'package:ai_assistant_app/view/screens/home/ai_assistant/chat/messages_bloc/messages_bloc.dart';
import 'package:ai_assistant_app/app/name_cubit/name_cubit.dart';
import 'package:ai_assistant_app/view/screens/home/ai_assistant/chat/chat_page.dart';
import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:ai_assistant_app/view/widgets/loading_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart' as bidi;

class ConversationsScreen extends StatelessWidget {
  const ConversationsScreen({super.key});
  static const pageRoute = '/conversations_screen';
  static String? _chatTitle;
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BlocBuilder<NameCubit, String?>(
          builder: (context, state) {
            return Text(state ?? appLocalizations.assistant);
          },
        ),
      ),
      body: BlocConsumer<ConversationCubit, ConversationState>(
        listener: (context, state) {
          if (state is ConversationCreatedState) {
            context.push('${ChatScreen.pageRoute}/${state.id}/$_chatTitle');
          }
        },
        builder: (context, state) {
          return BlocBuilder<ConversationCubit, ConversationState>(
            builder: (context, state) {
              log('conversation state is : $state');
              if (state is ConversationLoadingState) {
                return const LoadingIndicator();
              }
              if (state is GotConversationsState) {
                final conversations = state.conversations;
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 5),
                  itemCount: state.conversations.length,
                  itemBuilder: (context, index) {
                    final conversation = conversations[index];
                    TextDirection textDirection =
                        bidi.Bidi.startsWithRtl(conversation.title)
                            ? TextDirection.rtl
                            : TextDirection.ltr;
                    return Directionality(
                      textDirection: textDirection,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 2,
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: ColorsManger.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(3),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(88, 0, 0, 0),
                                offset: Offset(3, 3),
                                blurRadius: 3,
                              )
                            ],
                          ),
                          child: ListTile(
                            title: Text(conversations[index].title),
                            onTap: () {
                              //?todo : we will create get conversation messages.
                              context.read<MessagesBloc>().add(
                                  OpenConversationMessagePageEvent(
                                      conversation.id));
                              //todo: we will need it later when we need to clear the conversation
                              context.push(
                                  '${ChatScreen.pageRoute}/${conversation.id}/${conversation.title}');
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              if (state is NoConversationState) {
                return Center(
                  child: Text(appLocalizations.noConversation),
                );
              }
              return Container();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          newConversationDialog(context, isNew: true);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  newConversationDialog(
    BuildContext context, {
    required bool isNew,
  }) {
    final appLocalization = AppLocalizations.of(context)!;
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            appLocalization.start_new_conversation,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          scrollable: true,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 100,
          ),
          content: Column(
            children: [
              TextField(
                controller: controller,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(appLocalization.cancel),
            ),
            TextButton(
              onPressed: () {
                _chatTitle = controller.value.text;
                context
                    .read<ConversationCubit>()
                    .startNewConversation(_chatTitle!);
                Navigator.of(context).pop();
              },
              child: Text(
                appLocalization.create,
              ),
            ),
          ],
        );
      },
    );
  }
}
