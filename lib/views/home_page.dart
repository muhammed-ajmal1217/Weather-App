import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/controller/list_controller.dart';
import 'package:myapp/controller/location_controller.dart';
import 'package:myapp/controller/provider.dart';
import 'package:myapp/service/city_weather_api_service.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchControl = TextEditingController();
  @override
  void initState() {
    super.initState();
    getCurrentLocation(context);
  }

  CityWeatherApiService cityWeather=CityWeatherApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/pexels-brakou-abdelghani-1723637.jpg'),
                    fit: BoxFit.fill)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Consumer<CityWeatherProvider>(
                  builder: (context, pro, child) => 
                   Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      Visibility(
                        visible: pro.isLoaded,
                        replacement: const Center(child: CircularProgressIndicator()),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height:
                                  MediaQuery.of(context).size.height * 0.060,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 254, 254, 254)
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: TextFormField(
                                  onFieldSubmitted: (String city) {
                                     pro.cityname = city;
                                      cityWeather.getCityWeather(pro.cityname,context);
                                      pro.isLoaded = false; 
                                  },
                                  controller: searchControl,
                                  cursorColor: Colors.white,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                  decoration: InputDecoration(
                                      hintText: 'Search City...',
                                      hintStyle: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white),
                                      prefixIcon: Icon(
                                        Icons.search_rounded,
                                        size: 20,
                                        color: Colors.white.withOpacity(0.9),
                                      ),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Icons.pin_drop_outlined,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    pro.cityname,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 25,fontWeight: FontWeight.w600)
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      spacingheight(20),
                      Image.asset('assets/2i4n_h467_140625-removebg-preview.png',height: 150,),
                        spacingheight(20),
                      Row(
                        children: [
                          spacingheight(10),
                      weatherList(context,
                          image: 'assets/thermometer.png',
                          text: 'Temperature   ',text1: '${pro.temp.toStringAsFixed(2)}℃'),
                      SizedBox(width: 10,),
                      weatherList(context,
                          image: 'assets/barometer.png',
                          text: 'Pressure   ',text1: '${pro.press.toStringAsFixed(1)} hPa'),
                      spacingheight(20),
                        ],
                      ),
                      spacingheight(10),
                     Row(
                      children: [
                         weatherList(context,
                          image: 'assets/humidity.png',
                          text: 'Humidity   ',text1: '${pro.hum.toStringAsFixed(0)}%'),
                      SizedBox(width: 10,),
                      weatherList(context,
                          image: 'assets/clouds.png',
                          text: 'Cloud cover   ',text1: '${pro.cover.toStringAsFixed(0)}%'),
                      spacingheight(20),
                      ],
                     )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
