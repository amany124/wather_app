import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class getWeatherCubit extends Cubit<weatherStates> {
  WeatherModel? weather_data;
  getWeatherCubit() : super(weatherInitState());

  getWeather(String cityName) async {
    try {
      weather_data = await WeatherService().getCurrentWeather(cityName);
      emit(weatherLoadedState());
    } catch (e) {
      emit(weatherFailureState());
    }
  }
}
