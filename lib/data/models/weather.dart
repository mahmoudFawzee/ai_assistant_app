final class Weather {
  final String name;
  final int code;
  final double cloud;
  final _MainWeather main;
  final _WeatherOverView overView;
  final _Wind wind;
  final _Sys sys;
  const Weather({
    required this.name,
    required this.code,
    required this.cloud,
    required this.main,
    required this.overView,
    required this.wind,
    required this.sys,
  });
  factory Weather.fromJson(Map<String, Object?> json) {
    final cloud = json['cloud'] as Map<String, Object>;
    return Weather(
      name: json['name'] as String,
      code: json['code'] as int,
      cloud: cloud['all'] as double,
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
      temp: targetJson['temp'] as double,
      feelsLike: targetJson['feels_like'] as double,
      tempMin: targetJson['temp_min'] as double,
      tempMax: targetJson['temp_max'] as double,
      pressure: targetJson['pressure'] as double,
      humidity: targetJson['humidity'] as double,
      seaLevel: targetJson['1024'] as double,
      grndLevel: targetJson['1023'] as double,
    );
  }
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
      icon: targetJson[0]['icon'],
    );
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
    final targetJson = json['wind'] as Map<String, Object?>;
    return _Wind(
      speed: targetJson['speed'] as double,
      deg: targetJson['deg'] as double,
      gust: targetJson['gust'] as double,
    );
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
    final targetJson = json['sys'] as Map<String, Object?>;
    return _Sys(
      countryCode: targetJson['country'] as String,
      sunRise: targetJson['sunrise'].toString(),
      sunSet: targetJson['sunset'].toString(),
    );
  }
}
