import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constants/app_colors.dart';
import 'package:weather_app/presentation/bloc/temperature_unit_bloc/cubit/temperature_unit_cubit.dart';
import 'package:weather_app/presentation/widgets/background.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
        screen: Column(
          children: [
            const Text(
              "Settings",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            BlocBuilder<TemperatureUnitCubit, TemperatureUnit>(
              builder: (context, unit) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white.withOpacity(0.2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Celsius',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                        Switch(
                          value: unit == TemperatureUnit.fahrenheit,
                          onChanged: (value) {
                            context.read<TemperatureUnitCubit>().toggleUnit();
                          },
                        ),
                        const Text('Fahrenheit', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16),),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        isNight: DateTime.now().hour < 6 || DateTime.now().hour > 16);
  }
}
