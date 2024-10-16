import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/deg_to_direction.dart';
import 'package:weather_app/core/utils/is_night.dart';
import 'package:weather_app/domain/workmanager/usecases/work_manager_usecase.dart';
import 'package:weather_app/presentation/bloc/permissions_bloc/cubit/permissions_cubit.dart';
import 'package:weather_app/presentation/bloc/weather%20bloc/cubit/weather_cubit.dart';
import 'package:weather_app/presentation/widgets/background.dart';
import 'package:weather_app/presentation/widgets/home.dart';
import 'package:weather_app/presentation/widgets/loading_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherCubit>(
      create: (context) => WeatherCubit()..getCurrentWeatherByPosition(),
      child: BlocConsumer<PermissionsCubit, PermissionsState>(
        listener: (context, state) {
          bool isDialogActive = ModalRoute.of(context)?.isCurrent != true;
          if (state is LocationServiceDisabled && !isDialogActive) {
            _showLocationServiceDisabledDialog(context);
          } else if (state is LocationServiceEnabled) {
            BlocProvider.of<PermissionsCubit>(context)
                .requestLocationPermission();
          } else if (state is LocationWhenInUseGranted ||
              state is LocationAlwaysGranted) {
            BlocProvider.of<WeatherCubit>(context)
                .getCurrentWeatherByPosition();
          } else if (state is LocationAndNotificationsGranted) {
            BlocProvider.of<WeatherCubit>(context)
                .getCurrentWeatherByPosition();
            WorkManagerUsecase().call();
          }
        },
        builder: (context, state) {
          if (state is PermissionsDenied || state is LocationServiceDisabled) {
            return const Center(
              child: Text(
                  'Please, turn on location service for better user experience.'),
            );
          } else if (state is LocationAndNotificationsGranted ||
              state is LocationWhenInUseGranted ||
              state is LocationAlwaysGranted) {
            return BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, weatherState) {
                if (weatherState is WeatherLoading) {
                  return const LoadingWidget();
                } else if (weatherState is WeatherSuccess) {
                 
                  bool isNight = isNightTime(weatherState.currentWeather.dt!,
                  weatherState.currentWeather.timezone!);
                  return Background(
                    isNight:  isNight , 
                    screen: RefreshIndicator(
                      onRefresh: ()async{
                        context.read<WeatherCubit>().getCurrentWeatherByPosition();
                      },
                      child: Home(
                        cityName: weatherState.currentWeather.cityName,
                        weatherCondition:
                            weatherState.currentWeather.weather![0].main,
                        temp: weatherState.currentWeather.main!.temp,
                        windSpeed: weatherState.currentWeather.wind!.speed,
                        humidity: weatherState.currentWeather.main!.humidity,
                        icon: weatherState.currentWeather.weather![0].icon,
                        windDirection: degToDirection(weatherState.currentWeather.wind!.deg!),
                        pressure: weatherState.currentWeather.main!.pressure,
                        feelsLike: weatherState.currentWeather.main!.feelsLike,  
                        visibility: weatherState.currentWeather.visibility, 
                        
                      ),
                    ),
                  );
                } else if (weatherState is WeatherFailed) {
                  return Background(
                    isNight: true,
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
                                        .getCurrentWeatherByPosition();
                                  },
                                  icon: const Icon(
                                    Icons.refresh,
                                    color: Colors.grey,
                                  )),
                            ]),
                    ),
                  );
                }else{
                 return const LoadingWidget();
                }
                
              },
            );
          } else {
            return  const LoadingWidget();
          }
        },
      ),
    );
  }

  void _showLocationServiceDisabledDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Location service is disabled."),
          content: const Text(
              "Please enable location service for better experience."),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                openLocationSettings();
              },
              child: const Text("Settings"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void openLocationSettings() {
    AndroidIntent intent = const AndroidIntent(
      action: 'android.settings.LOCATION_SOURCE_SETTINGS',
    );
    intent.launch();
  }
}
