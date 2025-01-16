abstract class WeatherApiInterface {
  Future<Map<String,Object?>> getWeather({required double lat,required double lng});
}
