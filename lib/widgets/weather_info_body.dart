import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/widgets/get_theme_color_fun.dart';

class WeatherInfoBody extends StatelessWidget {
  const WeatherInfoBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<getWeatherCubit>(context)
    // this line will returns getWeatherCubit() object which you can use it to acess any method or variable in the cubit.

    WeatherModel weather_data =
        BlocProvider.of<getWeatherCubit>(context).weather_data!;
    return Container(
      // changing the background color using the condition
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          // get theme color method will return material color which is map { key , value}
          //   key: int   value : color
          // we have to acess one chade from this palete and use it in the list
          getThemeColor(
              weather_data.weatherCondition)[500]!, // this is a single color
          getThemeColor(weather_data.weatherCondition)[300]!,
          getThemeColor(weather_data.weatherCondition)[50]!,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weather_data.cityName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            Text(
              'updated at ${weather_data.date.hour}:${weather_data.date.minute}',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  'http:${weather_data.image}',
                ),
                Text(
                  weather_data.temp.round().toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Maxtemp:${weather_data.maxtemp.round()}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Mintemp: ${weather_data.mintemp.round()}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
             
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              weather_data.weatherCondition,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
