  import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myapp/provider/provider.dart';
import 'package:provider/provider.dart';

getCurrentLocation(BuildContext context) async {
    final pro = Provider.of<CityWhetherProvider>(context,listen: false);
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      return;
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true,
      );

      if (position != null) {
        print('lat:${position.latitude},long:${position.longitude}');
        pro.getCurrentCityWeather(position);
      } else {
        print('data unavailable');
      }
    }
  }