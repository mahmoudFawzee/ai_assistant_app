final class ImagesManger {
  static const _base = 'assets/images';
  static const _categories = '$_base/categories';
  static const _weather = '$_base/weather icons';
  static const _onBoarding = '$_base/on_boarding';
  static const splashImage = '$_base/assistant.png';
  static const weatherImage = '$_base/weather.png';
  static const todoImage = '$_base/todo.png';
  static const educationCategory = '$_categories/education.png';
  static const familyCategory = '$_categories/family.png';
  static const otherCategory = '$_categories/other.png';
  static const funCategory = '$_categories/entertainment.png';
  static const workCategory = '$_categories/work.png';
  static const allCategories = '$_categories/all.png';
  static const onBoardingAiAssistant = '$_onBoarding/virtual-assistant.png';
  static const onBoardingToDo = '$_onBoarding/work-order.png';
  static const onBoardingWeather = '$_onBoarding/weather-news.png';
  static String handleWeatherIconUrl(String url) {
    //open weather icon url form https://openweathermap.org/img/w/11n.png
    final imgName = url.substring(32);
    return '$_weather/$imgName';
  }
}
