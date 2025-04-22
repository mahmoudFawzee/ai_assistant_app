part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherInitialState extends WeatherState {
  const WeatherInitialState();
}

final class WeatherLoadingState extends WeatherState {
  const WeatherLoadingState();
}

final class GotTodayWeatherState extends WeatherState {
  final Weather weather;
  const GotTodayWeatherState(this.weather);
  @override
  List<Object> get props => [weather];
}

final class GotWeatherErrorState extends WeatherState {
  final String error;
  const GotWeatherErrorState(this.error);
  @override
  List<Object> get props => [error];
}
