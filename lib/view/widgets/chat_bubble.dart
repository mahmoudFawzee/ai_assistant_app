import 'package:ai_assistant_app/data/models/message_spec.dart';
import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.messageSpec,
  });
  final MessageSpec messageSpec;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: getCrossAxisAlignment(messageSpec.isMe),
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 30),
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: EdgeInsets.only(
              top: 15,
              bottom: 5,
              left: getMargin(messageSpec.isMe),
              right: getMargin(!messageSpec.isMe),
            ),
            decoration: BoxDecoration(
              color: getColor(messageSpec.isMe),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: getBorderRadius(messageSpec.isMe),
                bottomRight: getBorderRadius(!messageSpec.isMe),
              ),
            ),
            child: Text(
              messageSpec.title,
              textAlign: getTextAlign(messageSpec.isMe),
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 10,
              softWrap: true,
            ),
          ),
        ),
      ],
    );
  }

  CrossAxisAlignment getCrossAxisAlignment(bool isMe) =>
      !messageSpec.isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end;
  double getMargin(bool isMe) => isMe ? 30 : 5;
  Color getColor(bool isMe) =>
      isMe ? ColorsManger.myMessageColor : ColorsManger.aiMessageColor;
  Radius getBorderRadius(bool isMe) =>
      isMe ? const Radius.circular(20) : Radius.zero;
  TextAlign getTextAlign(bool isMe) => isMe ? TextAlign.end : TextAlign.start;
}
