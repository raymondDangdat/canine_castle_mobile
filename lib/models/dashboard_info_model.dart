// To parse this JSON data, do
//
//     final dashboardInfoModel = dashboardInfoModelFromJson(jsonString);

import 'dart:convert';

DashboardInfoModel dashboardInfoModelFromJson(String str) =>
    DashboardInfoModel.fromJson(json.decode(str));

class DashboardInfoModel {
  dynamic message;
  DashboardInfoData data;
  dynamic success;

  DashboardInfoModel({
    required this.message,
    required this.data,
    required this.success,
  });

  factory DashboardInfoModel.fromJson(Map<String, dynamic> json) =>
      DashboardInfoModel(
        message: json["message"],
        data: DashboardInfoData.fromJson(json["data"]),
        success: json["success"],
      );
}

class DashboardInfoData {
  CanineOfTheDay canineOfTheDay;
  List<CanineOfTheDay> canineAroundYou;
  List<NearestClinic> nearestClinics;
  List<RecentCrossDeal> recentCrossDeals;
  List<CanineOfTheDay> myCanines;
  List<Favorite> favorite;

  DashboardInfoData({
    required this.canineOfTheDay,
    required this.canineAroundYou,
    required this.nearestClinics,
    required this.recentCrossDeals,
    required this.myCanines,
    required this.favorite,
  });

  factory DashboardInfoData.fromJson(Map<String, dynamic> json) =>
      DashboardInfoData(
        canineOfTheDay: CanineOfTheDay.fromJson(json["canine_of_the_day"]),
        canineAroundYou: List<CanineOfTheDay>.from(
            json["canine_around_you"].map((x) => CanineOfTheDay.fromJson(x))),
        nearestClinics: List<NearestClinic>.from(
            json["nearest_clinics"].map((x) => NearestClinic.fromJson(x))),
        recentCrossDeals: List<RecentCrossDeal>.from(
            json["recent_cross_deals"].map((x) => RecentCrossDeal.fromJson(x))),
        myCanines: List<CanineOfTheDay>.from(
            json["my_canines"].map((x) => CanineOfTheDay.fromJson(x))),
        favorite: List<Favorite>.from(
            json["favorite"].map((x) => Favorite.fromJson(x))),
      );
}

class CanineOfTheDay {
  dynamic id;
  dynamic name;
  dynamic gender;
  dynamic slug;
  CanineOfTheDayRelationships relationships;

  CanineOfTheDay({
    required this.id,
    required this.name,
    required this.gender,
    required this.slug,
    required this.relationships,
  });

  factory CanineOfTheDay.fromJson(Map<String, dynamic> json) => CanineOfTheDay(
        id: json["id"],
        name: json["name"],
        gender: json["gender"],
        slug: json["slug"],
        relationships:
            CanineOfTheDayRelationships.fromJson(json["relationships"]),
      );
}

class CanineOfTheDayRelationships {
  dynamic breed;
  dynamic state;
  List<dynamic> pictures;
  Reviews reviews;

  CanineOfTheDayRelationships(
      {required this.breed,
      required this.pictures,
      required this.reviews,
      required this.state});

  factory CanineOfTheDayRelationships.fromJson(Map<String, dynamic> json) =>
      CanineOfTheDayRelationships(
        breed: json["breed"],
        state: json['state'],
        pictures: List<String>.from(json["pictures"].map((x) => x)),
        reviews: Reviews.fromJson(json["reviews"]),
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

class Favorite {
  dynamic id;
  dynamic slug;
  Relationship relationship;

  Favorite({
    required this.id,
    required this.slug,
    required this.relationship,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        id: json["id"],
        slug: json["slug"],
        relationship: Relationship.fromJson(json["relationship"]),
      );
}

class Relationship {
  GivenTo givenTo;

  Relationship({
    required this.givenTo,
  });

  factory Relationship.fromJson(Map<String, dynamic> json) => Relationship(
        givenTo: GivenTo.fromJson(json["given_to"]),
      );
}

class GivenTo {
  dynamic type;
  dynamic name;
  dynamic state;
  dynamic breed;
  List<dynamic> pictures;
  Reviews reviews;

  GivenTo({
    required this.type,
    required this.name,
    required this.state,
    required this.breed,
    required this.pictures,
    required this.reviews,
  });

  factory GivenTo.fromJson(Map<String, dynamic> json) => GivenTo(
        type: json["type"],
        name: json["name"],
        state: json["state"],
        breed: json["breed"],
        pictures: List<String>.from(json["pictures"].map((x) => x)),
        reviews: Reviews.fromJson(json["reviews"]),
      );
}

class NearestClinic {
  dynamic id;
  dynamic name;
  dynamic address;
  dynamic slug;
  NearestClinicRelationships relationships;

  NearestClinic({
    required this.id,
    required this.name,
    required this.address,
    required this.slug,
    required this.relationships,
  });

  factory NearestClinic.fromJson(Map<String, dynamic> json) => NearestClinic(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        slug: json["slug"],
        relationships:
            NearestClinicRelationships.fromJson(json["relationships"]),
      );
}

class NearestClinicRelationships {
  dynamic state;
  dynamic coverImage;
  Reviews reviews;

  NearestClinicRelationships({
    required this.state,
    required this.coverImage,
    required this.reviews,
  });

  factory NearestClinicRelationships.fromJson(Map<String, dynamic> json) =>
      NearestClinicRelationships(
        state: json["state"],
        coverImage: json["cover_image"],
        reviews: Reviews.fromJson(json["reviews"]),
      );
}

class RecentCrossDeal {
  dynamic id;
  dynamic name;
  dynamic slug;
  RecentCrossDealRelationships relationships;

  RecentCrossDeal({
    required this.id,
    required this.name,
    required this.slug,
    required this.relationships,
  });

  factory RecentCrossDeal.fromJson(Map<String, dynamic> json) =>
      RecentCrossDeal(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        relationships:
            RecentCrossDealRelationships.fromJson(json["relationships"]),
      );
}

class RecentCrossDealRelationships {
  List<dynamic> pictures;

  RecentCrossDealRelationships({
    required this.pictures,
  });

  factory RecentCrossDealRelationships.fromJson(Map<String, dynamic> json) =>
      RecentCrossDealRelationships(
        pictures: List<String>.from(json["pictures"].map((x) => x)),
      );
}
