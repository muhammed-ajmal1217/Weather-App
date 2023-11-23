import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/model/model.dart';
import '../constants/constants.dart' as k;
class WeatherApiService {
  Future<WeatherModel?> getCurrentCityWeather(Position position) async {
    var client = http.Client();
    var uri =
        '${k.domain}lat=${position.latitude}&lon=${position.longitude}&appid=${k.apiKey}';
    var url = Uri.parse(uri);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      return WeatherModel.fromJson(json.decode(data));
    } else {
      print('API request failed with status code: ${response.statusCode}');
      return null;
    }
  }
}