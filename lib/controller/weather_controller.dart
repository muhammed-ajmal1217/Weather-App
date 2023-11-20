  import 'package:flutter/material.dart';
import 'package:myapp/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart' as k;
import 'dart:convert';

getCityWeather(String cityname,BuildContext context) async {
    final pro = Provider.of<CityWhetherProvider>(context,listen: false);
    var client = http.Client();
    var uri = '${k.domain}q=${cityname}&appid=${k.apiKey}';
    var url = Uri.parse(uri);
    var respose = await client.get(url);
    if (respose.statusCode == 200) {
      var data = respose.body;
      var decodedData = json.decode(data);
      print(data);
      pro.updateUi(decodedData);
        pro.isLoaded = true;
    } else {
      print(respose.statusCode);
    }
  }