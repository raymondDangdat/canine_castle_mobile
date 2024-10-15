// To parse this JSON data, do
//
//     final retrievedUserInfoModel = retrievedUserInfoModelFromJson(jsonString);

import 'dart:convert';

RetrievedUserInfoModel retrievedUserInfoModelFromJson(String str) =>
    RetrievedUserInfoModel.fromJson(json.decode(str));

class RetrievedUserInfoModel {
  dynamic message;
  Data data;
  dynamic success;

  RetrievedUserInfoModel({
    required this.message,
    required this.data,
    required this.success,
  });

  factory RetrievedUserInfoModel.fromJson(Map<String, dynamic> json) =>
      RetrievedUserInfoModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
        success: json["success"],
      );
}

class Data {
  dynamic name;

  Data({
    required this.name,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
      );
}
