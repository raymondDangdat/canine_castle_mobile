// To parse this JSON data, do
//
//     final petBreedModel = petBreedModelFromJson(jsonString);

import 'dart:convert';

PetBreedModel petBreedModelFromJson(String str) =>
    PetBreedModel.fromJson(json.decode(str));

class PetBreedModel {
  List<PetBreedData> data;
  dynamic message;
  dynamic success;

  PetBreedModel({
    required this.data,
    required this.message,
    required this.success,
  });

  factory PetBreedModel.fromJson(Map<String, dynamic> json) => PetBreedModel(
        data: List<PetBreedData>.from(
            json["data"].map((x) => PetBreedData.fromJson(x))),
        message: json["message"],
        success: json["success"],
      );
}

class PetBreedData {
  dynamic id;
  dynamic name;
  dynamic description;
  dynamic slug;

  PetBreedData({
    required this.id,
    required this.name,
    required this.description,
    required this.slug,
  });

  factory PetBreedData.fromJson(Map<String, dynamic> json) => PetBreedData(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        slug: json["slug"],
      );
}
