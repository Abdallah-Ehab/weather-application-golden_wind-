import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/constants/data_constants.dart';

class ApiServices {
  Dio dio;

  ApiServices({required this.dio}) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        log("requested message");
        handler.next(options);
      },
      onResponse: (response, handler) {
        log("response recieved");
        handler.next(response);
      },
      onError: (error, handler) {
        log('Error[${error.response?.statusCode}] => MESSAGE: ${error.message}');

        String errorMessage = errorHandler(error);
        DioException newError = error.copyWith(
          error: errorMessage,
        );
        return handler.next(newError);
      },
    ));
  }

  Future<Either<dynamic, String>> getCurrentWeatherByCity(
    String city,
  ) async {
    return apiServiceHelperFunction(
        url: weatherUrl,
        query: {
          "q": city,
          "units": "metric",
          "appid": apiKey,
        },
        unknownErrorMessage: "Unkown error fetching weather by city.");
  }

  Future<Either<dynamic, String>> getCurrentWeatherByPosition(
    Position position,
  ) async {
    return apiServiceHelperFunction(
        url: weatherUrl,
        query: {
          "lon": "${position.longitude}",
          "lat": "${position.latitude}",
          "units": "metric",
          "appid": apiKey,
        },
        unknownErrorMessage: "Unkown error fetching weather by position.");
  }

  Future<Either<dynamic, String>> getForecastByCity(String city) async {
    return apiServiceHelperFunction(
        url: forecastUrl,
        query: {
          "q": city,
          "units": "metric",
          "appid": apiKey,
        },
        unknownErrorMessage:
            'Unknown error fetching 5 day forecast weather by city.');
  }

  Future<Either<dynamic, String>> getForecastByPosition(
      Position position) async {
    return apiServiceHelperFunction(
        url: forecastUrl,
        query: {
          "lon": "${position.longitude}",
          "lat": "${position.latitude}",
          "units": "metric",
          "appid": apiKey,
        },
        unknownErrorMessage:
            "Unkown error fetching 5 day forecast weather by position.");
  }

  Future<Either<dynamic, String>> getSuggestedCities(String query) async {
    try {
      final Response response = await dio.get(
          'http://api.openweathermap.org/geo/1.0/direct?q=$query&limit=5&appid=$apiKey');
      return left(response.data);
    } on DioException catch (e) {
      log(e.toString());
      return right('${e.error}');
    } catch (e) {
      return right('Unkown error fetching suggested cities');
    }
  }

  Future<Either<dynamic, String>> getCityNameByPosition(
      Position position) async {
    return apiServiceHelperFunction(
      url: getCityNameByPositionUrl,
      query: {
        'lon': '${position.longitude}',
        'lat': '${position.latitude}',
        'limit': '5',
        'appid': apiKey
      },
      unknownErrorMessage: 'Unknown Error fetching city name',
    );
  }

  String errorHandler(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionError:
        return "connection error";
      case DioExceptionType.badResponse:
        return "Error 404";
      case DioExceptionType.sendTimeout:
        return "send timeout";
      default:
        return "unknown error";
    }
  }

  Future<Either<dynamic, String>> apiServiceHelperFunction(
      {required String url,
      required Map<String, String> query,
      required String unknownErrorMessage}) async {
    try {
      final Response response = await dio.get(url, queryParameters: query);
      return left(response.data);
    } on DioException catch (e) {
      return right("${e.error}");
    } catch (e) {
      return right(unknownErrorMessage);
    }
  }
}
