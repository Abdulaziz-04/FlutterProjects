import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'weather_screen.dart';
import 'weather_info.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocationWeather() async {
    Weather w = await WeatherInfo().getWeather();
    //Pops previous Loading Screen
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return WeatherScreen(w);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getLocationWeather();
  }

  @override
  Widget build(BuildContext context) {
    return SpinKitWave(
      color: Colors.white,
    );
  }
}
