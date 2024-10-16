import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/bloc/weather%20bloc/cubit/weather_cubit.dart';

class TestPage extends StatelessWidget {
  final String city;
  const TestPage({required this.city, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherCubit>(
      create: (context) => WeatherCubit()..getCurrentWeatherByCity(city),
      child: Scaffold(
        body: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WeatherFailed) {
              return SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.error),
                    IconButton(
                        onPressed: () {
                          context
                              .read<WeatherCubit>()
                              .getCurrentWeatherByPosition();
                        },
                        icon: const Icon(Icons.refresh)),
                  ],
                ),
              );
            } else if (state is WeatherSuccess) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${state.currentWeather.cityName}'),
                    Text("${state.currentWeather.weather![0].main}"),
                    Text('${state.currentWeather.main!.temp!.round()}°C'),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
