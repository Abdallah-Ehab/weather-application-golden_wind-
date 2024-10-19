
bool isNightTime(int timestamp, int timezoneOffsetInSeconds) {

 
  DateTime utcDateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
  

  
  DateTime cityLocalDateTime = utcDateTime.add(Duration(seconds: timezoneOffsetInSeconds));
  

  
  int hour = cityLocalDateTime.hour;
  
  
  bool isNight = hour < 6 || hour >= 18;

  return isNight;
}