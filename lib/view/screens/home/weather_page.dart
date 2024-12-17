import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});
  static const pageRoute = '/weather_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('weather'),
      ),
      body: const Center(
        child: Text(
          'weather',
        ),
      ),
    );
  }
}
