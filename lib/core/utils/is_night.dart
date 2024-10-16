import 'dart:developer';

bool isNightTime(int timestamp, int timezoneOffsetInSeconds) {
  log("Received timestamp: $timestamp");
  log("Timezone offset in seconds: $timezoneOffsetInSeconds");

 
  DateTime utcDateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
  log("Converted DateTime (UTC): $utcDateTime");

  
  DateTime cityLocalDateTime = utcDateTime.add(Duration(seconds: timezoneOffsetInSeconds));
  log("City local DateTime: $cityLocalDateTime");

  
  int hour = cityLocalDateTime.hour;
  log("Extracted hour (City local time): $hour");

  
  bool isNight = hour < 6 || hour >= 18;
  log("Is it night time? $isNight");

  return isNight;
}