import 'package:weather/weather.dart';
import 'Location.dart';

const apiKey = '981c403f30afea6fa97eba629a078755';

class WeatherInfo {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  Future<dynamic> getWeather() async {
    WeatherFactory wf = new WeatherFactory(apiKey);
    Location location = Location();
    await location.getLocation();
    Weather w = await wf.currentWeatherByLocation(
        location.latitude, location.longitude);
    return w;
  }

  Future<dynamic> getCityWeather(String cityName) async {
    WeatherFactory wf = new WeatherFactory(apiKey);
    Weather w = await wf.currentWeatherByCityName(cityName);
    return w;
  }
}
