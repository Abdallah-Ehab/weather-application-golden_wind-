import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
// Required for BackdropFilter
import 'package:weather_app/core/constants/text_style.dart';
import 'package:weather_app/presentation/bloc/forecast_weather_bloc/cubit/forecast_weather_cubit.dart';
import 'package:weather_app/presentation/bloc/temperature_unit_bloc/cubit/temperature_unit_cubit.dart';
import 'package:weather_app/presentation/pages/forecast_full_report_screen.dart';
import 'package:weather_app/presentation/widgets/hourly_weather.dart';
import 'package:weather_app/presentation/widgets/weather_report.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  final String? cityName, weatherCondition, icon, windDirection;
  final num? temp, windSpeed, humidity, feelsLike, pressure, visibility;
  const Home(
      {required this.cityName,
      super.key,
      required this.weatherCondition,
      required this.temp,
      required this.windSpeed,
      required this.humidity,
      required this.icon,
      required this.feelsLike,
      required this.pressure,
      required this.visibility,
      required this.windDirection});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    BlocProvider.of<ForecastWeatherCubit>(context)
        .getForecastWeatherByPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              widget.cityName ?? '',
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
                height: 250,
                child: Image.asset('assets/images/${widget.icon}.png')),
            const SizedBox(
              height: 15,
            ),
            Text(
              widget.weatherCondition ?? '',
              style: TextStyles.h2,
            ),
            const SizedBox(
              height: 30,
            ),
            BlocBuilder<TemperatureUnitCubit, TemperatureUnit>(
              builder: (context, unit) {
                final cubit = context.read<TemperatureUnitCubit>();
                final temp = cubit.convertTemperature(widget.temp!);
                final unitSymbol = cubit.getUnitSymbol();
                return WeatherReport(
                  informations: [
                    WeatherInfo(
                        info: 'Temp', value: '${temp.round()}$unitSymbol'),
                    WeatherInfo(info: 'Wind', value: '${widget.windSpeed}Km/h'),
                    WeatherInfo(info: 'Humidity', value: '${widget.humidity}%'),
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
                      // Navigate to ForecastFullReportScreen using the existing ForecastWeatherCubit
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<ForecastWeatherCubit>(),
                            child: const ForecastFullReportScreen(),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'View Full Report',
                      style: TextStyle(
                          color: Color.fromARGB(255, 150, 201, 255),
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
              child: BlocBuilder<ForecastWeatherCubit, ForecastWeatherState>(
                builder: (context, state) {
                  if (state is ForecastWeatherLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  } else if (state is ForecastWeatherSuccess) {
                    return HourlyWeatherState(
                      forecastCurrentWeather:
                          state.forecastWeather.forecastCurrentWeather,
                    );
                  } else if (state is ForecastWeatherFailed) {
                    return Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.error,
                              style: const TextStyle(color: Colors.white),
                            ),
                            IconButton(
                              onPressed: () {
                                context
                                    .read<ForecastWeatherCubit>()
                                    .getForecastWeatherByPosition();
                              },
                              icon: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                            ),
                          ]),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 158, 139, 228).withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: GridView.count(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                children: [
                  _buildInfoCard(
                      Icons.water, 'Humidity', "${widget.humidity}%"),
                  BlocBuilder<TemperatureUnitCubit,TemperatureUnit>(
                    builder: (context, state) {
                      final cubit = context.read<TemperatureUnitCubit>();
                      final feelsLike = cubit.convertTemperature(widget.feelsLike ?? 0);
                      final unitSymbol = cubit.getUnitSymbol();
                      return _buildInfoCard(Icons.thermostat, 'Feels like',
                          '$feelsLike$unitSymbol');
                    },
                  ),
                  _buildInfoCard(
                      Icons.speed, 'Wind speed', widget.windSpeed.toString()),
                  _buildInfoCard(Icons.navigation, 'Wind direction',
                      widget.windDirection ?? ''),
                  _buildInfoCard(
                      Icons.dashboard, 'Pressure', '${widget.pressure} hPa'),
                  _buildInfoCard(Icons.visibility, 'Visibility',
                      '${widget.visibility} km'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildInfoCard(IconData icon, String title, String value) {
  return Card(
    color: Colors.white.withOpacity(0.1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 25),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
                color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}
