import 'package:ai_assistant_app/app/constants/on_boarding.dart';
import 'package:ai_assistant_app/domain/models/on_boarding/on_boarding.dart';
import 'package:ai_assistant_app/view/screens/home/ai_assistant/conversations/conversations_page.dart';
import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  static const pageRoute = '/on_boarding_screen';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        children: List.generate(onBoarding.length, (index) {
          return OnBoardingItem(
            isLastPage: index == onBoarding.length - 1,
            pageContent: onBoarding[index],
          );
        }),
      ),
    );
  }
}

class OnBoardingItem extends StatelessWidget {
  const OnBoardingItem({
    super.key,
    required this.isLastPage,
    required this.pageContent,
  });

  final OnBoardingObject pageContent;
  final bool isLastPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Image.asset(pageContent.onBoarding.image),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  pageContent.onBoarding.title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: ColorsManger.onBoardingTitle,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                pageContent.onBoarding.description,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: ColorsManger.onBoardingDescription,
                ),
              ),
            ],
          ),
          if (isLastPage)
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.go(ConversationsScreen.pageRoute);
                  },
                  child: const Text('Get Started'),
                ),
              ],
            )
        ],
      ),
    );
  }
}
