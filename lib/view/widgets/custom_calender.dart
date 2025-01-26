import 'package:flutter/material.dart';

class CustomCalender extends StatelessWidget {
  const CustomCalender({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Container();
        },
      ),
    );
  }
}
