import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/local%20notification/local_notification.dart';
import 'package:weather_app/data/permissions/repository/permissions_repo_implementation.dart';
import 'package:weather_app/data/weather/repository/geolocator_repo_implementation.dart';
import 'package:weather_app/data/weather/repository/weather_repo_implementation.dart';
import 'package:weather_app/presentation/bloc/forecast_weather_bloc/cubit/forecast_weather_cubit.dart';
import 'package:weather_app/presentation/bloc/permissions_bloc/cubit/permissions_cubit.dart';
import 'package:weather_app/presentation/bloc/temperature_unit_bloc/cubit/temperature_unit_cubit.dart';
import 'package:weather_app/presentation/pages/main_screen.dart';
import 'package:weather_app/service_locator.dart';
import 'package:weather_app/themes/theme_manager.dart';
import 'package:workmanager/workmanager.dart';

Future<void> notificationTask() async {
  try {
    LocalNotification localNotification = LocalNotification.instance;
    await localNotification.initialize();
    Position currentPosition =
        await GeolocatorRepoImplementation().getPosition();
    final weatherResponse = await WeatherRepoImplementation()
        .getCurrentWeatherByPositionAndNotify(currentPosition);
    weatherResponse.fold((data) {
      if(data.weather![0].id! < 800) {
        localNotification.showNotifications(
          title: '${data.weather![0].main}',
          body:
              'Current weather in ${data.cityName}: ${data.weather![0].description}',
          payload: data.weather![0].description!,
        );
      }
    }, (error) {
      log(error);
    });
  } catch (e) {
    log(e.toString());
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      await notificationTask();
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(ThemeManager.mySystemTheme);
  initializeServiceLocator();

  Workmanager().initialize(
    isInDebugMode: false,
    callbackDispatcher,
  );

  // Workmanager().registerPeriodicTask(
  //   "1",
  //   "periodicNotification",
  //   frequency: const Duration(minutes: 15),
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PermissionsCubit>(
          create: (context) => PermissionsCubit(PermissionsRepoImplementation())
            ..requestLocationService(),
        ),
        BlocProvider<ForecastWeatherCubit>(
            create: (context) => ForecastWeatherCubit()),
        BlocProvider<TemperatureUnitCubit>(
            create: (context) => TemperatureUnitCubit()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
      ),
    );
  }
}
