import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/Model/weather_model.dart';

Future<WeatherModel> getWeather(String lat, String lon) async {
  Uri myUri = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=2b8b7101d9672d2e006ace59d2a5eee9&units=metric");
  final response = await http.get(myUri);

  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    var model = WeatherModel.fromJson(result);
    return model;
  } else {
    throw Exception('Filed to load Weather Information');
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(title: Text('WEATHER APP')),
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Center(
            child: FutureBuilder<WeatherModel>(
              future: getWeather('35.032', '139.025'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  WeatherModel? model = snapshot.data;

                  // Format Date
                  var fm = new DateFormat('HH:mm dd EEE MM yyyy');
                  var fm_hour = new DateFormat.Hm();
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Weather in ${model!.name}',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold)),

                      /** Create Row with Image And Temperature */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                              'https://openweathermap.org/img/w/${model.weather[0].icon}.png'),
                          Text('${model.main.temp}°C',
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Text('${fm.format(new DateTime.fromMicrosecondsSinceEpoch((model.dt*1000), isUtc: true))}',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold)),
                      Text('Wind(Speed/Deg): ${model.wind.speed} / ${model.wind.deg}',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold)),
                      Text('Pressure: ${model.main.pressure}hpa',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold)),
                      Text('Humidity: ${model.main.humidity}%',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold)),
                      Text('Sunrise: ${fm_hour.format(new DateTime.fromMillisecondsSinceEpoch((model.sys.sunrise * 1000), isUtc: true))}',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold)),
                      Text('Sunset: ${fm_hour.format(new DateTime.fromMillisecondsSinceEpoch((model.sys.sunset * 1000), isUtc: true))}',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold)),
                      Text('GeoCode: [${model.coord.lat}/${model.coord.lon}',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold)),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.data!.name}°C',
                      style: TextStyle(fontSize: 30.0, color: Colors.red));
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
