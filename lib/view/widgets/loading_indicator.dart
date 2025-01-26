import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: ColorsManger.myMessageColor,
      ),
    );
  }
}
