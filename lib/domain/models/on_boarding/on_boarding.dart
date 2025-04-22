final class OnBoarding {
  
  final String title;
  final String description;
  final String image;
  const OnBoarding({
    
    required this.title,
    required this.description,
    required this.image,
  });
}

final class OnBoardingObject {
  final OnBoarding onBoarding;
  const OnBoardingObject({
    required this.onBoarding,
  });
}
