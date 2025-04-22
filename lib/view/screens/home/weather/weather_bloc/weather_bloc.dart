import 'dart:developer';
import 'dart:io';
import 'package:ai_assistant_app/data/key/json_keys.dart';
import 'package:ai_assistant_app/domain/models/weather/weather.dart';
import 'package:ai_assistant_app/data/services/weather/weather_api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final _weatherApiService = WeatherService();
  WeatherBloc() : super(const WeatherInitialState()) {
    on<GetTodayWeatherEvent>((event, emit) async {
      emit(const WeatherLoadingState());
      try {
        final res = await _weatherApiService.getWeather();
        log('res : $res');
        final resCode = res[JsonKeys.code];
        if (resCode == HttpStatus.ok) {
          final weather = res[JsonKeys.content] as Weather;
          emit(GotTodayWeatherState(weather));
          return;
        }
        //todo:we will return a map of response and message instead of just null
        //todo:or weather object.
        emit(const GotWeatherErrorState('something went wrong'));
      } catch (e) {
        emit(GotWeatherErrorState(e.toString()));
      }
    });
  }
}
