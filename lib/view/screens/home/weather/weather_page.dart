import 'package:ai_assistant_app/view/screens/home/weather/weather_bloc/weather_bloc.dart';
import 'package:ai_assistant_app/view/resources/images_manger.dart';
import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});
  static const pageRoute = '/weather_screen';
  Widget _imageHandler(String imageUrl) {
    try {
      return Image.network(
        imageUrl,
        scale: 1.5,
        fit: BoxFit.contain,
      );
    } catch (e) {
      return Image.asset(
        ImagesManger.handleWeatherIconUrl(imageUrl),
        scale: 1.5,
        fit: BoxFit.contain,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLocalizations.todayWeather,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          context.read<WeatherBloc>().add(const GetTodayWeatherEvent());
        },
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is GotTodayWeatherState) {
              final weather = state.weather;
              return Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  children: [
                    //?city which we got its weather
                    Center(child: Text(weather.cityName)),
                    const SizedBox(height: 10),
                    //?a small description about today's weather
                    Center(child: Text(weather.overView.description)),
                    const SizedBox(height: 10),
                    //?icon of the weather provided from the api
                    Center(
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: _imageHandler(weather.overView.icon),
                      ),
                    ),

                    //?current temp in celsius
                    Center(
                      child: Text(
                        '${weather.main.temp.toStringAsFixed(1)}\u00B0',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        weatherExtraInfo(
                          label: 'Wind Speed',
                          content: '${weather.wind.speed}',
                        ),
                        const SizedBox(width: 25),
                        weatherExtraInfo(
                          label: 'Humidity',
                          content: '${weather.main.humidity}%',
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
            if (state is WeatherLoadingState) {
              return const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: ColorsManger.aiMessageColor,
                  ),
                ),
              );
            }
            if (state is GotWeatherErrorState) {
              final topPadding = MediaQuery.of(context).size.height / 4;
              return ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: topPadding),
                  children: [
                    Center(
                      child: Text(state.error),
                    ),
                  ]);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Container weatherExtraInfo({
    required String label,
    required String content,
  }) {
    return Container(
      width: 150,
      height: 100,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: const BoxDecoration(
        color: ColorsManger.myMessageColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              color: ColorsManger.white,
            ),
          ),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.center,
            child: Text(
              content,
              style: const TextStyle(
                fontSize: 14,
                color: ColorsManger.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
