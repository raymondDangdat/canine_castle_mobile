// To parse this JSON data, do
//
//     final bankAccountModel = bankAccountModelFromJson(jsonString);

import 'dart:convert';

BankAccountModel bankAccountModelFromJson(String str) =>
    BankAccountModel.fromJson(json.decode(str));

class BankAccountModel {
  List<BankAccountData> data;
  dynamic message;
  dynamic success;

  BankAccountModel({
    required this.data,
    required this.message,
    required this.success,
  });

  factory BankAccountModel.fromJson(Map<String, dynamic> json) =>
      BankAccountModel(
        data: List<BankAccountData>.from(
            json["data"].map((x) => BankAccountData.fromJson(x))),
        message: json["message"],
        success: json["success"],
      );
}

class BankAccountData {
  dynamic id;
  dynamic accountName;
  dynamic accountNumber;
  dynamic bankName;
  dynamic bankLogo;

  BankAccountData({
    required this.id,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.bankLogo,
  });

  factory BankAccountData.fromJson(Map<String, dynamic> json) =>
      BankAccountData(
        id: json["id"],
        accountName: json["account_name"],
        accountNumber: json["account_number"],
        bankName: json["bank_name"],
        bankLogo: json["bank_logo"],
      );
}
