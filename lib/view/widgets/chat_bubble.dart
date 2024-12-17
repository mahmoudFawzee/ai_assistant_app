<<<<<<< HEAD
import 'package:ai_assistant_app/logic/them_cubit/theme_cubit.dart';
import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
=======
import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:flutter/material.dart';
>>>>>>> b54be31 (work on ui)

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
<<<<<<< HEAD
  });
  final String message;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool?>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: state == true ? ColorsManger.white : ColorsManger.black,
          ),
          child: Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      },
=======
    required this.isMe,
  });
  final String message;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          !isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: EdgeInsets.only(
            top: 15,
            bottom: 5,
            left: isMe ? 30 : 5,
            right: !isMe ? 30 : 5,
          ),
          decoration: BoxDecoration(
            color: isMe
                ? ColorsManger.myMessageColor
                : ColorsManger.aiMessageColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomLeft: isMe ? const Radius.circular(20) : Radius.zero,
              bottomRight: isMe ? Radius.zero : const Radius.circular(20),
            ),
          ),
          child: Text(
            message,
            textAlign: isMe ? TextAlign.end : TextAlign.start,
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 10,
            softWrap: true,
          ),
        ),
      ],
>>>>>>> b54be31 (work on ui)
    );
  }
}
