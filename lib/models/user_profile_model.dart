// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

import 'package:canine_castle_mobile/models/user_model.dart';


UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

class UserProfileModel {
  UserData data;
  dynamic message;
  dynamic success;

  UserProfileModel({
    required this.data,
    required this.message,
    required this.success,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        data: UserData.fromJson(json["data"]),
        message: json["message"],
        success: json["success"],
      );
}
