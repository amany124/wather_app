import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  Dio dio = Dio();
  String baseUrl = 'http://api.weatherapi.com/v1';
  String apiKey = '06d4815e39cd4984927112715230308';
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    try {
      Response response = await dio
          .get('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=1');

      WeatherModel weather_model = WeatherModel.fromjson(response.data);
      return weather_model;
    } on DioException catch (e) {
      String message =
          e.response?.data['error']['message'] ?? 'opps there was an error';
      log(message);
      throw Exception(message);
    } catch (e) {
      log(e.toString());
      throw Exception('opps there was an error try later');
    }
  }
}
