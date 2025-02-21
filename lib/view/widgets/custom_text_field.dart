import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.maxLines,
    required this.minLines,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String hint;
  final int maxLines, minLines;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorsManger.myMessageColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      minLines: minLines,
      maxLines: maxLines,
      onChanged: onChanged,
    );
  }
}
