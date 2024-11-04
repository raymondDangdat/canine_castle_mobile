// To parse this JSON data, do
//
//     final singleCanineModel = singleCanineModelFromJson(jsonString);

import 'dart:convert';

import 'canines_model.dart';

SingleCanineModel singleCanineModelFromJson(String str) =>
    SingleCanineModel.fromJson(json.decode(str));

class SingleCanineModel {
  SingleCanineData data;
  dynamic message;
  dynamic success;

  SingleCanineModel({
    required this.data,
    required this.message,
    required this.success,
  });

  factory SingleCanineModel.fromJson(Map<String, dynamic> json) =>
      SingleCanineModel(
        data: SingleCanineData.fromJson(json["data"]),
        message: json["message"],
        success: json["success"],
      );
}

class SingleCanineData {
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
  DataRelationships relationships;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  SingleCanineData({
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

  factory SingleCanineData.fromJson(Map<String, dynamic> json) =>
      SingleCanineData(
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
        relationships: DataRelationships.fromJson(json["relationships"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );
}

class DataRelationships {
  dynamic breed;
  dynamic state;
  dynamic city;
  Owner? owner;
  List<dynamic> pictures;
  Reviews reviews;

  DataRelationships({
    required this.breed,
    required this.state,
    required this.city,
    this.owner,
    required this.pictures,
    required this.reviews,
  });

  factory DataRelationships.fromJson(Map<String, dynamic> json) =>
      DataRelationships(
        breed: json["breed"],
        state: json["state"],
        city: json["city"],
        owner: json['owner'] == null ? null : Owner.fromJson(json["owner"]),
        pictures: List<String>.from(json["pictures"].map((x) => x)),
        reviews: Reviews.fromJson(json["reviews"]),
      );
}

class OwnerRelationships {
  String country;
  String profileImage;

  OwnerRelationships({
    required this.country,
    required this.profileImage,
  });

  factory OwnerRelationships.fromJson(Map<String, dynamic> json) =>
      OwnerRelationships(
        country: json["country"],
        profileImage: json["profile_image"],
      );
}

class Reviews {
  int totalRatingAnalysis;
  int totalReviewsCount;
  List<dynamic> reviewers;

  Reviews({
    required this.totalRatingAnalysis,
    required this.totalReviewsCount,
    required this.reviewers,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
        totalRatingAnalysis: json["total_rating_analysis"],
        totalReviewsCount: json["total_reviews_count"],
        reviewers: List<dynamic>.from(json["reviewers"].map((x) => x)),
      );
}
