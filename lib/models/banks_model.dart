// To parse this JSON data, do
//
//     final bankModel = bankModelFromJson(jsonString);

import 'dart:convert';

BankModel bankModelFromJson(String str) => BankModel.fromJson(json.decode(str));

class BankModel {
  List<BankData> data;
  dynamic message;
  dynamic success;

  BankModel({
    required this.data,
    required this.message,
    required this.success,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        data:
            List<BankData>.from(json["data"].map((x) => BankData.fromJson(x))),
        message: json["message"],
        success: json["success"],
      );
}

class BankData {
  dynamic id;
  dynamic name;
  dynamic code;
  dynamic ussd;
  dynamic logo;
  dynamic slug;

  BankData({
    required this.id,
    required this.name,
    required this.code,
    required this.ussd,
    required this.logo,
    required this.slug,
  });

  factory BankData.fromJson(Map<String, dynamic> json) => BankData(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        ussd: json["ussd"],
        logo: json["logo"],
        slug: json["slug"],
      );
}
