import 'package:flutter/material.dart';
import 'package:myapp/controller/provider.dart';
import 'package:myapp/views/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CityWeatherProvider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
      ),
    );
  }
}


