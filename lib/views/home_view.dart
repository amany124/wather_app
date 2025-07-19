import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/views/search_view.dart';
import 'package:weather_app/widgets/no_weather_body.dart';
import 'package:weather_app/widgets/weather_info_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchView();
                }));
              },
              icon: Icon(Icons.search)),
        ],
      ),

      // managing the states using the getWeatherCubit
      // using bloc builder you can build the ui using the states from the cubit
      // here the bloc builder is listening for the cubit
      // first he will display the init state
      // when the request finish and the data comes he will display the weather info body automatically without using set state;

      body: BlocBuilder<getWeatherCubit, weatherStates>(
        builder: (context, state) {
          if (state is weatherInitState) {
            return NoWeatherBody();
          } else if (state is weatherLoadedState) {
            return WeatherInfoBody();
          } else {
            return Text('opps there was an error');
          }
        },
      ),
    );
  }
}
