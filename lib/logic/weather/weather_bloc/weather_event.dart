part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

final class GetTodayWeatherEvent extends WeatherEvent {
  const GetTodayWeatherEvent();
}
