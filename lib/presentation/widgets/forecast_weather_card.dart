import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/core/constants/app_colors.dart';
import 'package:weather_app/core/constants/text_style.dart';

class ForecastWeatherCard extends StatelessWidget {
  final int index;
  final String hour, icon, unitSymbol;
  final num temp;
  const ForecastWeatherCard({required this.hour, required this.temp, required this.index,super.key, required this.icon, required this.unitSymbol});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: index==0?AppColors.lightBlue:const Color.fromARGB(255, 158, 139, 228).withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
        height: 50,
        width: 160,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 40, child: Image.asset("assets/images/$icon.png")),
            Padding(
              padding: const  EdgeInsets.all(8.0),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(hour,style: TextStyles.medium,),
                  Text('${temp.round()}$unitSymbol',style: TextStyles.h3,)
                ],
              ),
            )
          ],
        ),
        );
  }
}