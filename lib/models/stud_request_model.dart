// To parse this JSON data, do
//
//     final studRequestModel = studRequestModelFromJson(jsonString);

import 'dart:convert';

import 'canines_model.dart';

StudRequestModel studRequestModelFromJson(String str) => StudRequestModel.fromJson(json.decode(str));

class StudRequestModel {
  List<RequestData> data;
  Links links;
  Meta meta;
  dynamic message;
  dynamic success;

  StudRequestModel({
    required this.data,
    required this.links,
    required this.meta,
    required this.message,
    required this.success,
  });

  factory StudRequestModel.fromJson(Map<String, dynamic> json) => StudRequestModel(
    data: List<RequestData>.from(json["data"].map((x) => RequestData.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
    message: json["message"],
    success: json["success"],
  );
}

class RequestData {
  dynamic id;
  dynamic deal;
  dynamic offerAmount;
  dynamic message;
  dynamic status;
  dynamic studDate;
  dynamic remarks;
  dynamic slug;
  Relationship relationship;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  RequestData({
    required this.id,
    required this.deal,
    required this.offerAmount,
    required this.message,
    required this.status,
    required this.studDate,
    required this.remarks,
    required this.slug,
    required this.relationship,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory RequestData.fromJson(Map<String, dynamic> json) => RequestData(
    id: json["id"],
    deal: json["deal"],
    offerAmount: json["offer_amount"],
    message: json["message"],
    status: json["status"],
    studDate: json["stud_date"],
    remarks: json["remarks"],
    slug: json["slug"],
    relationship: Relationship.fromJson(json["relationship"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );
}

class Relationship {
  List<Pet> pets;

  Relationship({
    required this.pets,
  });

  factory Relationship.fromJson(Map<String, dynamic> json) => Relationship(
    pets: List<Pet>.from(json["pets"].map((x) => Pet.fromJson(x))),
  );
}

class Pet {
  dynamic id;
  dynamic name;
  dynamic gender;
  dynamic longitude;
  dynamic latitude;
  dynamic age;
  StudParams? studParams;
  dynamic slug;
  PetRelationships relationships;

  Pet({
    required this.id,
    required this.name,
    required this.gender,
    required this.longitude,
    required this.latitude,
    required this.age,
    this.studParams,
    required this.slug,
    required this.relationships,
  });

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
    id: json["id"],
    name: json["name"],
    gender: json["gender"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    age: json["age"],
    studParams: json["stud_params"] == null ? null : StudParams.fromJson(json["stud_params"]),
    slug: json["slug"],
    relationships: PetRelationships.fromJson(json["relationships"]),
  );
}


class PetRelationships {
  dynamic breed;
  dynamic state;
  dynamic city;
  Owner owner;
  List<String> pictures;
  Reviews reviews;

  PetRelationships({
    required this.breed,
    required this.state,
    required this.city,
    required this.owner,
    required this.pictures,
    required this.reviews,
  });

  factory PetRelationships.fromJson(Map<String, dynamic> json) => PetRelationships(
    breed: json["breed"],
    state: json["state"],
    city: json["city"],
    owner: Owner.fromJson(json["owner"]),
    pictures: List<String>.from(json["pictures"].map((x) => x)),
    reviews: Reviews.fromJson(json["reviews"]),
  );
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

}



class OwnerRelationships {
  dynamic country;
  dynamic profileImage;

  OwnerRelationships({
    required this.country,
    required this.profileImage,
  });

  factory OwnerRelationships.fromJson(Map<String, dynamic> json) => OwnerRelationships(
    country: json["country"],
    profileImage: json["profile_image"],
  );

}




class Reviews {
  dynamic totalRatingAnalysis;
  dynamic totalReviewsCount;

  Reviews({
    required this.totalRatingAnalysis,
    required this.totalReviewsCount,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
    totalRatingAnalysis: json["total_rating_analysis"],
    totalReviewsCount: json["total_reviews_count"],
  );
}


