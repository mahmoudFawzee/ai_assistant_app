import 'package:ai_assistant_app/data/models/message.dart';
import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          !message.isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: EdgeInsets.only(
            top: 15,
            bottom: 5,
            left: message.isMe ? 30 : 5,
            right: !message.isMe ? 30 : 5,
          ),
          decoration: BoxDecoration(
            color: message.isMe
                ? ColorsManger.myMessageColor
                : ColorsManger.aiMessageColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomLeft: message.isMe ? const Radius.circular(20) : Radius.zero,
              bottomRight: message.isMe ? Radius.zero : const Radius.circular(20),
            ),
          ),
          child: Text(
            message.title,
            textAlign: message.isMe ? TextAlign.end : TextAlign.start,
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 10,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
