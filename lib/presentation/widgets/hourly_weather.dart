import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/presentation/bloc/forecast_weather_bloc/cubit/forecast_weather_cubit.dart';
import 'package:weather_app/presentation/bloc/temperature_unit_bloc/cubit/temperature_unit_cubit.dart';
import 'package:weather_app/presentation/widgets/forecast_weather_card.dart';

// ignore: must_be_immutable
class HourlyWeather extends StatelessWidget {
  
  String cityName;
   HourlyWeather({super.key,required this.cityName});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForecastWeatherCubit()..getForecastWeatherByCity(cityName),
      child: BlocBuilder<ForecastWeatherCubit, ForecastWeatherState>(
        builder: (context, state) {
          if(state is ForecastWeatherSuccess){
            return buildHourlyWeatherList(context, state);
          }else if(state is ForecastWeatherFailed){
            return Center(
              child: Text(state.error,style: const TextStyle(color:Colors.white))
            );
          }else if(state is ForecastWeatherLoading){
            return const Center(
              child: CircularProgressIndicator(color: Colors.white,),
            );
          }else{
            return const Center(
              child: CircularProgressIndicator(color: Colors.white,),
            );
          }
        },
      ),
    );
  }
}


Widget buildHourlyWeatherList(BuildContext context,ForecastWeatherSuccess state){
return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 8,
            itemBuilder: (BuildContext context, int index) {
              int timeStamp = state.forecastWeather.forecastCurrentWeather![index].dt;
              DateTime dateTime =
                  DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
              String formattedDate =
                  DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
              final hour = formattedDate.split(' ')[1];
              num temp = state.forecastWeather.forecastCurrentWeather![index].main!.temp!;
              String icon = state.forecastWeather.forecastCurrentWeather![index].weather![0].icon!;
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