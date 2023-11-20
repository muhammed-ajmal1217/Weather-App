import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart' as k;

class CityWhetherProvider extends ChangeNotifier{
  bool isLoaded = false;
  num temp = 0;
  num press = 0;
  num hum = 0;
  num cover = 0;
    String cityname = '';
    getCurrentCityWeather(Position position) async {
    var client = http.Client();
    var uri =
        '${k.domain}lat=${position.latitude}&lon=${position.longitude}&appid=${k.apiKey}';
    var url = Uri.parse(uri);
    var respose = await client.get(url);
    if (respose.statusCode == 200) {
      var data = respose.body;
      var decodedData = json.decode(data);
      updateUi(decodedData);
        isLoaded = true;
    } else {
      print(respose.statusCode);
    }
    notifyListeners();
  }
    updateUi(var decodedData) {
      if (decodedData == null) {
        temp = 0;
        press = 0;
        hum = 0;
        cover = 0;
        cityname = 'Not available';
      } else {
        temp = decodedData['main']['temp'] - 273;
        press = decodedData['main']['pressure'];
        hum = decodedData['main']['humidity'];
        cover = decodedData['clouds']['all'];
        cityname = decodedData['name'];
      }
      notifyListeners();
  }
}