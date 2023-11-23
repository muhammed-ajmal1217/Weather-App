import 'package:flutter/material.dart';
import 'package:myapp/controller/provider.dart';
import 'package:myapp/model/model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart' as k;
import 'dart:convert';

Future<void> getCityWeather(String cityname, BuildContext context) async {
  try {
    final pro = Provider.of<CityWeatherProvider>(context, listen: false);
    var client = http.Client();
    var uri = '${k.domain}q=$cityname&appid=${k.apiKey}';
    var url = Uri.parse(uri);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      var data = response.body;
      var decodedData = json.decode(data);
      WeatherModel weatherModel = WeatherModel.fromJson(decodedData);

      pro.updateUi(weatherModel);
      pro.isLoaded = true;
    } else {
      print('Failed to fetch weather data. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching weather data: $error');
  }
}
