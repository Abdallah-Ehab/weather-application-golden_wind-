import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/app_colors.dart';
import 'package:weather_app/presentation/widgets/weakly_weather.dart';

class FullReport extends StatelessWidget {
  const FullReport({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      minChildSize: .5,
      maxChildSize: 1,
      builder: (context, scrollController){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.darkBlue,
          ),
          child: ListView.separated(
          itemCount: 10,
          controller: scrollController,
          itemBuilder: (context, index) {
            return const WeaklyWeather();
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 20,);
            },
            ),
          ),
        );
      },
    );
  }
}