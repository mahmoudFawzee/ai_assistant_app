// ignore_for_file: use_build_context_synchronously

import 'package:ai_assistant_app/app/cubit/old_user_cubit.dart';
import 'package:ai_assistant_app/view/resources/images_manger.dart';
import 'package:ai_assistant_app/view/resources/responsiveness_manger.dart';
import 'package:ai_assistant_app/view/screens/home/ai_assistant/conversations/conversations_page.dart';
import 'package:ai_assistant_app/view/screens/start/on_boarding/on_boarding_screen.dart';
import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const pageRoute = '/splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  move(bool oldUser) {
    Future.delayed(
      const Duration(
        seconds: 2,
        milliseconds: 500,
      ),
      () {
        if (oldUser) {
          context.go(ConversationsScreen.pageRoute);
          return;
        }
        context.go(OnBoardingScreen.pageRoute);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final resManger = ResponsivenessManger(context);
    return BlocListener<OldUserCubit, bool>(
      listener: (context, oldUser) {
        move(oldUser);
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(resManger.padding.pH10),
                margin: EdgeInsets.only(bottom: resManger.margin.mH10),
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorsManger.black, width: 1.5),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(ImagesManger.splashImage),
              ),
              Text(
                'Ai Assistant',
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}
