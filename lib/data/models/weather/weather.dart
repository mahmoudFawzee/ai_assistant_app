//?this is the weather model which we get all data about weather from it.
final class Weather {
  final String cityName;
  final int code;
  final double cloud;
  final _MainWeather main;
  final _WeatherOverView overView;
  final _Wind wind;
  final _Sys sys;
  const Weather({
    required this.cityName,
    required this.code,
    required this.cloud,
    required this.main,
    required this.overView,
    required this.wind,
    required this.sys,
  });
  factory Weather.fromJson(Map<String, Object?> json) {
    final clouds = json['clouds'] as Map<String, Object?>;
    return Weather(
      cityName: json['name'] as String,
      code: json['cod'] as int,
      cloud: _parseDouble('${clouds['all']}'),
      main: _MainWeather.fromJson(json),
      overView: _WeatherOverView.fromJson(json),
      wind: _Wind.fromJson(json),
      sys: _Sys.fromJson(json),
    );
  }
}

final class _MainWeather {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final double pressure;
  final double humidity;
  final double seaLevel;
  final double grndLevel;
  const _MainWeather({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.grndLevel,
    required this.seaLevel,
  });
  factory _MainWeather.fromJson(Map<String, Object?> json) {
    final targetJson = json['main'] as Map<String, Object?>;
    return _MainWeather(
      temp: _handleTemp(_parseDouble('${targetJson['temp']}')),
      feelsLike: _parseDouble('${targetJson['feels_like']}'),
      tempMin: _parseDouble('${targetJson['temp_min']}'),
      tempMax: _parseDouble('${targetJson['temp_max']}'),
      pressure: _parseDouble('${targetJson['pressure']}'),
      humidity: _parseDouble('${targetJson['humidity']}'),
      seaLevel: _parseDouble('${targetJson['sea_level']}'),
      grndLevel: _parseDouble('${targetJson['grnd_level']}'),
    );
  }
  //?we got temp in kelvin and we need to convert it to celsius
  static double _handleTemp(double kTemp) => kTemp - 273.15;
}

final class _WeatherOverView {
  final int id;
  final String main;
  final String description;
  final String icon;
  const _WeatherOverView({
    required this.id,
    required this.description,
    required this.icon,
    required this.main,
  });
  factory _WeatherOverView.fromJson(Map<String, Object?> json) {
    final targetJson = json['weather'] as List;
    return _WeatherOverView(
      id: targetJson[0]['id'],
      main: targetJson[0]['main'],
      description: targetJson[0]['description'],
      icon: _handleIconUrl(targetJson[0]['icon']),
    );
  }
  static String _handleIconUrl(String iconCode) =>
      'http://openweathermap.org/img/w/$iconCode.png';
  @override
  String toString() {
    return 'id : $id main : $main description : $description icon : $icon';
  }
}

final class _Wind {
  final double speed;
  final double deg;
  final double gust;
  const _Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory _Wind.fromJson(Map<String, Object?> json) {
    print('converting : wind');
    final targetJson = json['wind'] as Map<String, Object?>;
    return _Wind(
      speed: _parseDouble('${targetJson['speed']}'),
      deg: _parseDouble('${targetJson['deg']}'),
      gust: _parseDouble('${targetJson['gust']}'),
    );
  }
  @override
  String toString() {
    return 'speed : $speed deg : $deg gust : $gust';
  }
}

final class _Sys {
  final String sunRise;
  final String sunSet;
  final String countryCode;
  const _Sys({
    required this.countryCode,
    required this.sunRise,
    required this.sunSet,
  });
  factory _Sys.fromJson(Map<String, Object?> json) {
    print('converting : sys');
    final targetJson = json['sys'] as Map<String, Object?>;
    return _Sys(
      countryCode: targetJson['country'] as String,
      sunRise: targetJson['sunrise'].toString(),
      sunSet: targetJson['sunset'].toString(),
    );
  }
  @override
  String toString() {
    return 'country code : $countryCode sunrise : $sunRise sunset : $sunSet';
  }
}

double _parseDouble(String value) => double.parse(value);
