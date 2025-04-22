import 'package:ai_assistant_app/domain/models/on_boarding/on_boarding.dart';
import 'package:ai_assistant_app/view/resources/images_manger.dart';

const onBoarding = [
  OnBoardingObject(
    onBoarding: OnBoarding(
      image: ImagesManger.onBoardingAiAssistant,
      title: 'AI Assistant',
      description:
          'Your personal AI assistant to help you with daily tasks and queries.',
    ),
  ),
  OnBoardingObject(
    onBoarding: OnBoarding(
      image: ImagesManger.onBoardingToDo,
      title: 'Stay Organized',
      description:
          'Manage your tasks and to-do lists efficiently with our AI assistant.',
    ),
  ),
  OnBoardingObject(
    onBoarding: OnBoarding(
      image: ImagesManger.onBoardingWeather,
      title: 'Be Prepared',
      description:
          'Get the latest weather updates and forecasts to plan your day.',
    ),
  ),
];
