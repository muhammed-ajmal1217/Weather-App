
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myapp/model/model.dart';
import 'package:myapp/service/api_service.dart';

class CityWeatherProvider extends ChangeNotifier {
  WeatherApiService _weatherApiService = WeatherApiService();
  bool isLoaded = false;
  num temp = 0;
  num press = 0;
  num hum = 0;
  num cover = 0;
  String cityname = '';

getCurrentCityWeather(Position position) async {
  try {
    WeatherModel? weatherModel = await _weatherApiService.getCurrentCityWeather(position);
    if (weatherModel != null) {
      updateUi(weatherModel);
      isLoaded = true;
    } else {
      print('Weather data is null');
    }
  } catch (error) {
    print('Error fetching weather data: $error');
  }
  notifyListeners();
}


updateUi(WeatherModel? weatherModel) {
  if (weatherModel == null) {
    temp = 0;
    press = 0;
    hum = 0;
    cover = 0;
    cityname = 'Not available';
  } else {
    temp = weatherModel.main?.temp != null ? weatherModel.main!.temp! - 273 : 0;
    press = weatherModel.main?.pressure ?? 0;
    hum = weatherModel.main?.humidity ?? 0;
    cover = weatherModel.clouds?.all ?? 0;
    cityname = weatherModel.name ?? 'Not available';
  }
  notifyListeners();
}

}


