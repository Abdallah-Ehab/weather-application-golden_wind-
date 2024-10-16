import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/data/weather/models/forecast_current_weather.dart';
import 'package:weather_app/presentation/bloc/temperature_unit_bloc/cubit/temperature_unit_cubit.dart';
import 'package:weather_app/presentation/widgets/forecast_weather_card.dart';

class HourlyWeatherState extends StatelessWidget {
  final List<ForecastCurrentWeather>? forecastCurrentWeather;

  const HourlyWeatherState({required this.forecastCurrentWeather, super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) {
        int timeStamp = forecastCurrentWeather![index].dt;
        DateTime dateTime =
            DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
        String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
        final hour = formattedDate.split(' ')[1];
        num temp = forecastCurrentWeather![index].main!.temp!;
        String icon = forecastCurrentWeather![index].weather![0].icon!;
        final cubit = context.read<TemperatureUnitCubit>();
        final temperature = cubit.convertTemperature(temp);
        final unitSymbol = cubit.getUnitSymbol();
            return ForecastWeatherCard(
              hour: hour,
              temp: temperature,
              unitSymbol: unitSymbol,
              index: index,
              icon: icon,
            );
          
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          width: 20,
        );
      },
    );
  }
}
