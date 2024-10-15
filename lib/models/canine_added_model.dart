// To parse this JSON data, do
//
//     final canineAddedModel = canineAddedModelFromJson(jsonString);

import 'dart:convert';

CanineAddedModel canineAddedModelFromJson(String str) =>
    CanineAddedModel.fromJson(json.decode(str));

class CanineAddedModel {
  dynamic message;
  CanineAddedModelData data;
  dynamic success;

  CanineAddedModel({
    required this.message,
    required this.data,
    required this.success,
  });

  factory CanineAddedModel.fromJson(Map<String, dynamic> json) =>
      CanineAddedModel(
        message: json["message"],
        data: CanineAddedModelData.fromJson(json["data"]),
        success: json["success"],
      );
}

class CanineAddedModelData {
  dynamic id;
  dynamic name;
  dynamic gender;
  dynamic address;
  dynamic longitude;
  dynamic latitude;
  dynamic age;
  StudParams? studParams;
  dynamic isPublic;
  dynamic isPedigree;
  dynamic slug;
  DataRelationships? relationships;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  CanineAddedModelData({
    required this.id,
    required this.name,
    required this.gender,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.age,
    required this.studParams,
    required this.isPublic,
    required this.isPedigree,
    required this.slug,
    required this.relationships,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory CanineAddedModelData.fromJson(Map<String, dynamic> json) =>
      CanineAddedModelData(
        id: json["id"],
        name: json["name"],
        gender: json["gender"],
        address: json["address"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        age: json["age"],
        studParams: json['stud_params'] == null
            ? null
            : StudParams.fromJson(json["stud_params"]),
        isPublic: json["is_public"],
        isPedigree: json["is_pedigree"],
        slug: json["slug"],
        relationships: json['relationships'] == null
            ? null
            : DataRelationships.fromJson(json["relationships"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );
}

class DataRelationships {
  String breed;
  String state;
  String city;
  Owner owner;
  List<dynamic> pictures;

  DataRelationships({
    required this.breed,
    required this.state,
    required this.city,
    required this.owner,
    required this.pictures,
  });

  factory DataRelationships.fromJson(Map<String, dynamic> json) =>
      DataRelationships(
        breed: json["breed"],
        state: json["state"],
        city: json["city"],
        owner: Owner.fromJson(json["owner"]),
        pictures: List<dynamic>.from(json["pictures"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "breed": breed,
        "state": state,
        "city": city,
        "owner": owner.toJson(),
        "pictures": List<dynamic>.from(pictures.map((x) => x)),
      };
}

class Owner {
  dynamic id;
  dynamic name;
  dynamic phoneNumber;
  dynamic username;
  OwnerRelationships relationships;

  Owner({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.username,
    required this.relationships,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json["id"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        username: json["username"],
        relationships: OwnerRelationships.fromJson(json["relationships"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone_number": phoneNumber,
        "username": username,
        "relationships": relationships.toJson(),
      };
}

class OwnerRelationships {
  dynamic country;
  dynamic profileImage;

  OwnerRelationships({
    required this.country,
    required this.profileImage,
  });

  factory OwnerRelationships.fromJson(Map<String, dynamic> json) =>
      OwnerRelationships(
        country: json["country"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "profile_image": profileImage,
      };
}

class StudParams {
  StudParamsData data;

  StudParams({
    required this.data,
  });

  factory StudParams.fromJson(Map<String, dynamic> json) => StudParams(
        data: StudParamsData.fromJson(json["data"]),
      );
}

class StudParamsData {
  dynamic contractBrief;
  dynamic puppyDealAmount;
  dynamic noPuppyDealAmount;

  StudParamsData({
    required this.contractBrief,
    required this.puppyDealAmount,
    required this.noPuppyDealAmount,
  });

  factory StudParamsData.fromJson(Map<String, dynamic> json) => StudParamsData(
        contractBrief: json["contract_brief"],
        puppyDealAmount: json["puppy_deal_amount"],
        noPuppyDealAmount: json["no_puppy_deal_amount"],
      );
}
