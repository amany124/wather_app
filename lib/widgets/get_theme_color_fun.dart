import 'package:flutter/material.dart';

MaterialColor getThemeColor(condition) {
  if (condition == null) {
    return Colors.blue;
  }
  if (condition == 'Clear' || condition == 'Sunny') {
    return Colors.orange;
  } else if (condition == 'Sleet' ||
      condition == 'Snow' ||
      condition == 'Hail' ||
      condition == 'Light Cloud') {
    return Colors.blue;
  } else if (condition == 'Heavy Cloud') {
    return Colors.blueGrey;
  } else if (condition == 'Light Rain' ||
      condition == 'Heavy rain' ||
      condition == 'Showers ' ||
      condition == 'Patchy rain possible' ||
      condition == 'Moderate rain') {
    return Colors.blue;
  } else if (condition == 'Thunderstorm' || condition == 'Thunder') {
    return Colors.blueGrey;
  } else {
    return Colors.blue;
  }
}
