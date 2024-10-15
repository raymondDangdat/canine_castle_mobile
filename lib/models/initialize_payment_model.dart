// To parse this JSON data, do
//
//     final initializePaymentModel = initializePaymentModelFromJson(jsonString);

import 'dart:convert';

InitializePaymentModel initializePaymentModelFromJson(String str) =>
    InitializePaymentModel.fromJson(json.decode(str));

class InitializePaymentModel {
  dynamic message;
  Data data;
  dynamic success;

  InitializePaymentModel({
    required this.message,
    required this.data,
    required this.success,
  });

  factory InitializePaymentModel.fromJson(Map<String, dynamic> json) =>
      InitializePaymentModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
        success: json["success"],
      );
}

class Data {
  dynamic url;

  Data({
    required this.url,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        url: json["url"],
      );
}
