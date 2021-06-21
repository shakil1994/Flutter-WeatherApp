class Main {
  final double temp;

  final double feels_like;

  final double temp_min;

  final double temp_max;

  final int pressure;

  final int humidity;

  final double sea_level;

  final double grnd_level;

  Main(
      {required this.temp,
      required this.feels_like,
      required this.temp_min,
      required this.temp_max,
      required this.pressure,
      required this.humidity,
      required this.sea_level,
      required this.grnd_level});

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: double.parse(json['temp'].toString()),
      feels_like: double.parse(json['feels_like'].toString()),
      temp_min: double.parse(json['temp_min'].toString()),
      temp_max: double.parse(json['temp_max'].toString()),
      pressure: json['pressure'],
      humidity: json['humidity'],
      sea_level:
          json['sea_level'] == null ? 0.0 : double.parse(json['sea_level'].toString()),
      grnd_level:
          json['grnd_level'] == null ? 0.0 : double.parse(json['grnd_level'].toString()),
    );
  }
}
