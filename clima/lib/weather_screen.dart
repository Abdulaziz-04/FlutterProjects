import 'package:clima/loading_screen.dart';
import 'package:flutter/cupertino.dart';
import 'location_screen.dart';
import 'package:flutter/material.dart';
import 'weather_info.dart';

const boxHeight = 20.0;
const fontht = 30.0;

class WeatherScreen extends StatefulWidget {
  WeatherScreen(this.weatherData);
  final weatherData;
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  int temperature, windSpeed, condition;
  String city, weather, desc, inputCity;
  DateTime sunrise, sunset;
  WeatherInfo weatherObj = new WeatherInfo();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateWeatherData(widget.weatherData);
  }

  AssetImage getWeatherImage() {
    if (condition < 300) {
      return AssetImage('images/thunderstorm.jpg');
    } else if (condition < 600) {
      return AssetImage('images/rainy.jpg');
    } else if (condition < 700) {
      return AssetImage('images/snow.jpg');
    } else {
      if (DateTime.now().isAfter(sunrise) && DateTime.now().isBefore(sunset)) {
        return AssetImage('images/sun.jpg');
      } else if (DateTime.now().isAtSameMomentAs(sunset)) {
        return AssetImage('images/sunset.jpg');
      } else {
        return AssetImage('images/moon.jpg');
      }
    }
  }

  void updateWeatherData(dynamic weatherData) {
    if (!mounted) return;
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        windSpeed = 0;
        condition = 800;
        city = 'Unknown';
        desc = 'Couldn\'t connect Please try again';
        weather = 'Unknown';
        sunset = DateTime.now();
        sunrise = DateTime.now();
        return;
      }
      temperature = weatherData.temperature.celsius.toInt();
      windSpeed = weatherData.windSpeed.toInt();
      condition = weatherData.weatherConditionCode;
      city = weatherData.areaName;
      desc = weatherData.weatherDescription;
      weather = weatherData.weatherMain;
      sunset = weatherData.sunset;
      sunrise = weatherData.sunrise;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () async {
                      //pops previous weather screen
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoadingScreen();
                          },
                        ),
                      );
                      var w = await weatherObj.getWeather();
                      updateWeatherData(w);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      inputCity = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LocationScreen();
                          },
                        ),
                      );
                      if (inputCity != null) {
                        var w = await weatherObj.getCityWeather(inputCity);
                        updateWeatherData(w);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 50.0,
                      ),
                      Text(
                        '$temperature\u00b0C',
                        style: TextStyle(
                            fontSize: 60.0,
                            fontFamily: 'Spartan MB',
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: boxHeight,
                      ),
                      Text(
                        '${weatherObj.getWeatherIcon(condition)} $city',
                        style: TextStyle(
                          fontSize: fontht,
                        ),
                      ),
                      SizedBox(
                        height: boxHeight,
                      ),
                      Text(
                        '$weather',
                        style: TextStyle(
                            fontSize: fontht, fontFamily: 'Spartan MB'),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'Wind Speed : ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: fontht,
                            fontFamily: 'Spartan MB',
                            color: Colors.white70),
                      ),
                      Text(
                        '$windSpeed m/s',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: fontht,
                            fontFamily: 'Spartan MB',
                            color: Colors.white70),
                      ),
                      SizedBox(
                        height: boxHeight,
                      ),
                      Text(
                        '$desc',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: fontht,
                          fontFamily: 'Spartan MB',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: getWeatherImage(),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
        ),
      ),
    );
  }
}
