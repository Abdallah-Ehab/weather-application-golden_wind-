import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/bloc/temperature_unit_bloc/cubit/temperature_unit_cubit.dart';
import 'package:weather_app/presentation/bloc/weather%20bloc/cubit/weather_cubit.dart';

// ignore: must_be_immutable
class UndesmissibleSavedCityCard extends StatelessWidget {
  const UndesmissibleSavedCityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit()..getCurrentWeatherByPosition(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: InkWell(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    color: Colors.blue.withOpacity(0.1),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.white)),
                  child: BlocBuilder<WeatherCubit, WeatherState>(
                    builder: (context, state) {
                      if(state is WeatherLoading) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white,),
                        );
                      } else if(state is WeatherSuccess) {
                        final cubit = context.read<TemperatureUnitCubit>();
                        final temp = cubit.convertTemperature(state.currentWeather.main!.temp!);
                        final unitSymbol = cubit.getUnitSymbol();
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              state.currentWeather.cityName ?? '',
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
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                Text(
                                  state.currentWeather.weather![0].description ?? '',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Image.asset(
                              "assets/images/${state.currentWeather.weather![0].icon}.png",
                              height: 60,
                              width: 60,
                            ),
                          ],
                        );
                      } else if(state is WeatherFailed) {
                        return Center(
                          child: Text(state.error, style: const TextStyle(color: Colors.white),)
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white,),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
