import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'temperature_unit_state.dart';

enum TemperatureUnit { celsius, fahrenheit }

class TemperatureUnitCubit extends Cubit<TemperatureUnit> {
  TemperatureUnitCubit() : super(TemperatureUnit.celsius) {
    _loadUnitPreference();
  }

  Future<void> _loadUnitPreference() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUnit = prefs.getString('temperature_unit') ?? 'celsius';
    if (savedUnit == 'fahrenheit') {
      emit(TemperatureUnit.fahrenheit);
    } else {
      emit(TemperatureUnit.celsius);
    }
  }

  Future<void> toggleUnit() async {
    final prefs = await SharedPreferences.getInstance();
    if (state == TemperatureUnit.celsius) {
      emit(TemperatureUnit.fahrenheit);
      prefs.setString('temperature_unit', 'fahrenheit');
    } else {
      emit(TemperatureUnit.celsius);
      prefs.setString('temperature_unit', 'celsius');
    }
  }

  num convertTemperature(num tempCelsius) {
    if (state == TemperatureUnit.fahrenheit) {
      return (tempCelsius * 9 / 5) + 32;
    }
    return tempCelsius;
  }

  String getUnitSymbol() {
    return state == TemperatureUnit.fahrenheit ? '°F' : '°C';
  }
}
