import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/local%20storage/local_storage.dart';
import 'package:weather_app/core/utils/deg_to_direction.dart';
import 'package:weather_app/core/utils/is_night.dart';
import 'package:weather_app/presentation/bloc/weather%20bloc/cubit/weather_cubit.dart';
import 'package:weather_app/presentation/pages/saved_cities_page.dart';
import 'package:weather_app/presentation/widgets/background.dart';
import 'package:weather_app/presentation/widgets/home_details.dart';
import 'package:weather_app/presentation/widgets/loading_widget.dart';

class SearchedCityDetails extends StatelessWidget {
  final String cityName;
  final bool addcity;
  const SearchedCityDetails(
      {super.key, required this.cityName, required this.addcity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => WeatherCubit()..getCurrentWeatherByCity(cityName),
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, weatherState) {
            if (weatherState is WeatherLoading) {
              return const LoadingWidget();
            } else if (weatherState is WeatherSuccess) {
              bool isNight = isNightTime(weatherState.currentWeather.dt!,
                  weatherState.currentWeather.timezone!);

              return Background(
                isNight: isNight,
                screen: Stack(
                  children: [
                    RefreshIndicator(
                      onRefresh: () async {
                        context
                            .read<WeatherCubit>()
                            .getCurrentWeatherByCity(cityName);
                      },
                      child: HomeDetails(
                        cityName: weatherState.currentWeather.cityName,
                        weatherCondition:
                            weatherState.currentWeather.weather![0].main,
                        temp: weatherState.currentWeather.main!.temp,
                        windSpeed: weatherState.currentWeather.wind!.speed,
                        humidity: weatherState.currentWeather.main!.humidity,
                        icon: weatherState.currentWeather.weather![0].icon,
                        windDirection: degToDirection(
                            weatherState.currentWeather.wind!.deg!),
                        pressure: weatherState.currentWeather.main!.pressure,
                        feelsLike: weatherState.currentWeather.main!.feelsLike,
                        visibility: weatherState.currentWeather.visibility,
                        isNight: isNight,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 150,
                        height: 40,
                        child: addcity
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    backgroundColor:
                                        Colors.grey.withOpacity(0.2)),
                                onPressed: () {
                                  LocalStorage.savecity(
                                    weatherState.currentWeather.cityName,
                                    weatherState.currentWeather.main!.temp,
                                    weatherState
                                        .currentWeather.weather![0].main,
                                    weatherState
                                        .currentWeather.weather![0].icon,
                                  );
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const SavedCitiesPage()));
                                },
                                child: const Text(
                                  "Add City",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : Container(),
                      ),
                    ),
                  ],
                ),
              );
            } else if (weatherState is WeatherFailed) {
              return Background(
                screen: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          weatherState.error,
                          style: const TextStyle(color: Colors.white),
                        ),
                        IconButton(
                            onPressed: () {
                              context
                                  .read<WeatherCubit>()
                                  .getCurrentWeatherByCity(cityName);
                            },
                            icon: const Icon(
                              Icons.refresh,
                              color: Colors.grey,
                            )),
                      ]),
                ),
                isNight: true,
              );
            } else {
              return const LoadingWidget();
            }
          },
        ),
      ),
    );
  }
}
