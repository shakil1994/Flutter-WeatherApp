class Coord {
  final double lon;
  final double lat;

  Coord({required this.lon, required this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: json['lon'],
      lat: json['lat'],
      /*lat: json['lat'] == null ? 0.0 : double.parse(json['lat'].toString()),
      lat: json['lat'] == null ? 0.0 : double.parse(json['lat'].toString()),*/
    );
  }
}
