import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,

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
    );
  }
}
