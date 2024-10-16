import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/text_style.dart';

// ignore: must_be_immutable
class WeatherInfo extends StatelessWidget {
  WeatherInfo({super.key,required this.info,required this.value});
  String info ;
  String value;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          info,
          style: TextStyles.subtitleText,
          ),
        Text(
          value,
          style: TextStyles.h3,
          ),
      ],
    );
  }
}

// ignore: must_be_immutable
class WeatherReport extends StatelessWidget {
  WeatherReport({super.key,required this.informations});

  List<WeatherInfo> informations;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children:informations,
    );
  }
}

