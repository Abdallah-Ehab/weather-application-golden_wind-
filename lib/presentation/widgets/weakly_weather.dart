import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/core/constants/app_colors.dart';
import 'package:weather_app/core/constants/text_style.dart';
import 'package:weather_app/utility/icons.dart';

class WeaklyWeather extends StatelessWidget {
  const WeaklyWeather({super.key});



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.lightBlue,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(12, 10, 12, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Friday',
                  style: TextStyles.h1,
                ),
                const SizedBox(height: 8,),
                Text(
                  '${DateTime.now().month} ${DateTime.now().day}',
                  style: TextStyles.medium,
                )
              ],
            ),
            const Text(
              "24°C",
              style: TextStyles.h1,
            ),
            SizedBox(height:50 ,child: getIcons(id: 802)),
          ],
        ),
      ),
    );
  }
}
