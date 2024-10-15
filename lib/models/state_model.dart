// To parse this JSON data, do
//
//     final stateModel = stateModelFromJson(jsonString);

import 'dart:convert';

StateModel stateModelFromJson(String str) =>
    StateModel.fromJson(json.decode(str));

class StateModel {
  List<StateCityData> data;
  dynamic message;
  dynamic success;

  StateModel({
    required this.data,
    required this.message,
    required this.success,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        data: List<StateCityData>.from(
            json["data"].map((x) => StateCityData.fromJson(x))),
        message: json["message"],
        success: json["success"],
      );
}

class StateCityData {
  dynamic id;
  dynamic name;
  dynamic slug;

  StateCityData({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory StateCityData.fromJson(Map<String, dynamic> json) => StateCityData(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
      );
}
