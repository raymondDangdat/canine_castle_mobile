// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

class UserModel {
  dynamic token;
  dynamic tokenType;
  dynamic expiresIn;
  UserData user;
  dynamic success;

  UserModel({
    required this.token,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
    required this.success,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        token: json["token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        user: UserData.fromJson(json["user"]),
        success: json["success"],
      );
}

class UserData {
  dynamic id;
  dynamic email;
  DateTime emailVerifiedAt;
  dynamic activeStatus;
  dynamic role;
  Wallet wallet;
  Details details;

  UserData({
    required this.id,
    required this.email,
    required this.emailVerifiedAt,
    required this.activeStatus,
    required this.role,
    required this.wallet,
    required this.details,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        email: json["email"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        activeStatus: json["active_status"],
        role: json["role"],
        wallet: Wallet.fromJson(json["wallet"]),
        details: Details.fromJson(json["details"]),
      );
}

class Details {
  dynamic id;
  dynamic name;
  dynamic phoneNumber;
  dynamic username;
  dynamic address;
  dynamic vcn;
  dynamic clinicName;
  dynamic schedule;
  dynamic services;
  Relationships relationships;
  dynamic slug;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  Details({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.username,
    required this.address,
    required this.vcn,
    required this.clinicName,
    required this.schedule,
    required this.services,
    required this.relationships,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        id: json["id"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        username: json["username"],
        address: json["address"],
        vcn: json["vcn"],
        clinicName: json["clinic_name"],
        schedule: json["schedule"],
        services: json["services"],
        relationships: Relationships.fromJson(json["relationships"]),
        slug: json["slug"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );
}

class Relationships {
  dynamic country;
  dynamic state;
  dynamic coverImage;
  dynamic profileImage;

  Relationships({
    required this.country,
    required this.state,
    required this.coverImage,
    required this.profileImage,
  });

  factory Relationships.fromJson(Map<String, dynamic> json) => Relationships(
        country: json["country"],
        state: json["state"],
        coverImage: json["coverImage"],
        profileImage: json["profileImage"],
      );
}

class Wallet {
  dynamic id;
  dynamic balance;
  dynamic currency;

  Wallet({
    required this.id,
    required this.balance,
    required this.currency,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["id"],
        balance: json["balance"],
        currency: json["currency"],
      );
}
