// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/utils/is_night.dart';
import 'package:weather_app/presentation/bloc/forecast_weather_bloc/cubit/forecast_weather_cubit.dart';
import 'package:weather_app/presentation/bloc/temperature_unit_bloc/cubit/temperature_unit_cubit.dart';
import 'package:weather_app/presentation/widgets/background.dart';
import 'package:weather_app/presentation/widgets/loading_widget.dart';

class ForecastFullReportScreen extends StatelessWidget {
  final String cityName;
   const ForecastFullReportScreen({
    super.key,
    required this.cityName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ForecastWeatherCubit()..getForecastWeatherByCity(cityName),
        child: BlocBuilder<ForecastWeatherCubit, ForecastWeatherState>(
          builder: (context, state) {
            if (state is ForecastWeatherLoading) {
              return const LoadingWidget();
            } else if (state is ForecastWeatherFailed) {
              return Background(
                  screen: Center(
                    child: Text(state.error),
                  ),
                  isNight: true);
            } else if (state is ForecastWeatherSuccess) {
              final forecastWeatherlist =
                  state.forecastWeather.forecastCurrentWeather;
              final isNight = isNightTime(
                  state.forecastWeather.forecastCurrentWeather![0].dt,
                  state.forecastWeather.city!.timezone);
              return Background(
                isNight: isNight,
                screen: SizedBox(
                  width: double.infinity,
                  child: ListView.separated(
                    itemCount: forecastWeatherlist!.length,
                    itemBuilder: (context, index) {
                      int timeStamp = forecastWeatherlist[index].dt;
                      DateTime dateTime =
                          DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
                      String formattedDate =
                          DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
                      final hour = formattedDate.split(' ')[1];
                      num temp = forecastWeatherlist[index].main!.temp!;
                      String icon =
                          forecastWeatherlist[index].weather![0].icon!;
                      String desc =
                          forecastWeatherlist[index].weather![0].description!;
                      final cubit = context.read<TemperatureUnitCubit>();
                      final temperature = cubit.convertTemperature(temp);
                      final unitSymbol = cubit.getUnitSymbol();
                      return forecastCurrentWeatherCard(
                          icon, hour, temperature, unitSymbol, desc);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text("something is wrong I can feel it",style: TextStyle(color: Colors.white),),
              );
            }
          },
        ),
      ),
    );
  }
}

Widget forecastCurrentWeatherCard(
    String icon, String hour, num temp, String unitSymbol, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              width: double.infinity,
              height: 100,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  "assets/images/$icon.png",
                  height: 60,
                  width: 60,
                ),
                Text(
                  hour,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${temp.round()}$unitSymbol',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      desc,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
