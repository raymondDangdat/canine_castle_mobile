// To parse this JSON data, do
//
//     final accountNameModel = accountNameModelFromJson(jsonString);

import 'dart:convert';

AccountNameModel accountNameModelFromJson(String str) =>
    AccountNameModel.fromJson(json.decode(str));

class AccountNameModel {
  dynamic message;
  dynamic data;
  dynamic success;

  AccountNameModel({
    required this.message,
    required this.data,
    required this.success,
  });

  factory AccountNameModel.fromJson(Map<String, dynamic> json) =>
      AccountNameModel(
        message: json["message"],
        data: json["data"],
        success: json["success"],
      );
}
