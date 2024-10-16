import 'package:flutter/material.dart';

Widget getIcons({required int id}){
  int weatherId=id;
  if (weatherId == 801) {
    return Image.asset('images/04d.png');
  } else if (weatherId == 802) {
    return Image.asset('images/02d.png');
  } else if (weatherId == 803) {
    return Image.asset('images/12d.png');
  } else if (weatherId == 804) {
    return Image.asset('images/14d.png');
  } else if (weatherId == 800) {
    return Image.asset('images/01d.png');
  } else if (weatherId > 700) {
    return Image.asset('images/13d.png');
  } else if (weatherId >= 600) {
    return Image.asset('images/09d.png');
  } else if (weatherId >= 520) {
    return Image.asset('images/05d.png');
  } else if (weatherId == 511) {
    return Image.asset('images/06d.png');
  } else if (weatherId >= 500) {
    return Image.asset('images/07d.png');
  }else if(weatherId>=300){
    return Image.asset('images/10.png');
  }else{
    return Image.asset('images/08d.png');
  }
}