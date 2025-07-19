import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/views/home_view.dart';
import 'package:weather_app/widgets/get_theme_color_fun.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // the function of bloc provide is just to create
      // object from the weathercubit and provide this object
      //  for both widgets we will need to use this object at them
      create: (context) => getWeatherCubit(),
      child: Builder(builder: (context) {
        return MaterialApp(
          theme: ThemeData(
            // brightness: Brightness.dark or Brightness.light,
            primarySwatch: getThemeColor(
                BlocProvider.of<getWeatherCubit>(context)
                    .weather_data
                    ?.weatherCondition),
          ),
          home: HomeView(),
        );
      }),
    );
  }
}


