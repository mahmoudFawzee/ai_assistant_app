import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:ai_assistant_app/data/interface/weather_api_interface.dart';
import 'package:ai_assistant_app/data/key/api_keys.dart';
import 'package:ai_assistant_app/data/key/json_keys.dart';
import 'package:ai_assistant_app/data/models/weather.dart';
import 'package:http/http.dart' as http;

final class WeatherService implements WeatherApiInterface {
  @override
  Future<Map<String, Object?>> getWeather({
    required double lat,
    required double lng,
  }) async {
    final endPoint = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lng&appid=$weather_api_key',
    );
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $weather_api_key',
    };
    final res = await http.get(endPoint, headers: headers);
    final resCode = res.statusCode;
    final decodedBody = json.decode(res.body);
    if (resCode == HttpStatus.ok) {
      log(res.body);

      return {
        JsonKeys.content: Weather.fromJson(decodedBody),
        JsonKeys.message: 'accepted request',
        JsonKeys.code: resCode,
      };
    }
    return {
      JsonKeys.message: decodedBody[JsonKeys.message],
      JsonKeys.code: resCode,
      JsonKeys.content:null,
    };
  }
}
