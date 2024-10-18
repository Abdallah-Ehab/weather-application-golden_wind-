import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:weather_app/core/constants/text_style.dart';
import 'package:weather_app/presentation/bloc/temperature_unit_bloc/cubit/temperature_unit_cubit.dart';
import 'package:weather_app/presentation/pages/forecast_full_report_screen.dart';
import 'package:weather_app/presentation/widgets/build_info_card.dart';
import 'package:weather_app/presentation/widgets/hourly_weather.dart';
import 'package:weather_app/presentation/widgets/weather_report.dart';


// ignore: mustbeimmutable
class HomeDetails extends StatelessWidget {
  final String? cityName, weatherCondition, icon,windDirection;
  final num? temp, windSpeed, humidity,pressure,visibility,feelsLike;
  final bool isNight;
   const HomeDetails({
    required this.cityName,
    required this.weatherCondition,
    required this.temp,
    required this.windSpeed,
    required this.humidity,
    required this.icon,
    required this.isNight,
    super.key, required this.windDirection, required this.pressure, required this.visibility, required this.feelsLike,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              cityName ?? '',
              style: TextStyles.h1,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${DateFormat.MMMM().format(DateTime.now())} ${DateTime.now().day}, ${DateTime.now().year}',
              style: TextStyles.subtitleText,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 250, child: Image.asset('assets/images/$icon.png')),
            const SizedBox(
              height: 15,
            ),
            Text(
              weatherCondition ?? '',
              style: TextStyles.h2,
            ),
            const SizedBox(
              height: 30,
            ),
            BlocBuilder<TemperatureUnitCubit, TemperatureUnit>(
              builder: (context, unit) {
                final cubit = context.read<TemperatureUnitCubit>();
                final temp = cubit.convertTemperature(this.temp!);
                final unitSymbol = cubit.getUnitSymbol();
                return WeatherReport(
                  informations: [
                    WeatherInfo(
                        info: 'Temp', value: '${temp.round()}$unitSymbol'),
                    WeatherInfo(info: 'Wind', value: '${windSpeed}Km/h'),
                    WeatherInfo(info: 'Humidity', value: '$humidity%'),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Today',
                    style: TextStyles.large,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_)=>ForecastFullReportScreen(cityName: cityName!)
                        ),
                      );
                    },
                    child:  Text(
                      'View Full Report',
                      style: TextStyle(
                          color: isNight ? const Color.fromARGB(255, 150, 201, 255):const Color.fromARGB(255, 30, 23, 94),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              height: 80,
              child: HourlyWeather(cityName: cityName!)
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 158, 139, 228).withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: GridView.count(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                children: [
                 buildInfoCard(
                      Icons.water, 'Humidity', "$humidity%"),
                  BlocBuilder<TemperatureUnitCubit,TemperatureUnit>(
                    builder: (context, state) {
                      final cubit = context.read<TemperatureUnitCubit>();
                      final feelsLike = cubit.convertTemperature(this.feelsLike ?? 0);
                      final unitSymbol = cubit.getUnitSymbol();
                      return buildInfoCard(Icons.thermostat, 'Feels like',
                          '$feelsLike$unitSymbol');
                    },
                  ),
                  buildInfoCard(
                      Icons.speed, 'Wind speed', windSpeed.toString()),
                  buildInfoCard(Icons.navigation, 'Wind direction',
                      windDirection ?? ''),
                  buildInfoCard(
                      Icons.dashboard, 'Pressure', '$pressure hPa'),
                  buildInfoCard(Icons.visibility, 'Visibility',
                      '$visibility km'),
                      buildInfoCard(
                      Icons.dashboard, 'Pressure', '$pressure hPa'),
                  buildInfoCard(Icons.visibility, 'Visibility',
                      '$visibility km'),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
