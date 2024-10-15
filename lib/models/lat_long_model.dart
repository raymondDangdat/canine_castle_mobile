// To parse this JSON data, do
//
//     final latLongModel = latLongModelFromJson(jsonString);

import 'dart:convert';

LatLongModel latLongModelFromJson(String str) =>
    LatLongModel.fromJson(json.decode(str));

class LatLongModel {
  List<Result> results;
  dynamic status;

  LatLongModel({
    required this.results,
    required this.status,
  });

  factory LatLongModel.fromJson(Map<String, dynamic> json) => LatLongModel(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        status: json["status"],
      );
}

class Result {
  Geometry geometry;

  Result({
    required this.geometry,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        geometry: Geometry.fromJson(json["geometry"]),
      );
}

class Geometry {
  Location? location;

  Geometry({
    required this.location,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: json['location'] == null
            ? null
            : Location.fromJson(json["location"]),
      );
}

class Location {
  dynamic lat;
  dynamic lng;

  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"],
        lng: json["lng"],
      );
}
