import 'dart:core';

import 'package:weather_app/Model/clouds.dart';
import 'package:weather_app/Model/coord.dart';
import 'package:weather_app/Model/main.dart';
import 'package:weather_app/Model/sys.dart';
import 'package:weather_app/Model/weather.dart';
import 'package:weather_app/Model/wind.dart';

class WeatherModel {
  final Coord coord;

  final List<Weather> weather;

  final String base;

  final Main main;

  final Wind wind;

  final Clouds clouds;

  final int dt;

  final Sys sys;

  final int id;

  final String name;

  final int cod;

  final int visibility;

  final int timezone;

  WeatherModel({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.id,
    required this.name,
    required this.cod,
    required this.visibility,
    required this.timezone,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        coord: Coord.fromJson(json['coord']),
        weather: (json['weather'] as List)
            .map((item) => Weather.fromJson(item))
            .toList(),
        base: json['base'],
        main: Main.fromJson(json['main']),
        wind: Wind.fromJson(json['wind']),
        clouds: Clouds.fromJson(json['clouds']),
        dt: json['dt'],
        sys: Sys.fromJson(json['sys']),
        id: json['id'],
        name: json['name'],
        cod: json['cod'],
        visibility: json['visibility'],
        timezone: json['timezone']);
  }
}
