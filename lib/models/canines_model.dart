

import 'dart:convert';

CaninesModel caninesModelFromJson(String str) =>
    CaninesModel.fromJson(json.decode(str));

class CaninesModel {
  List<CanineData> data;
  Links links;
  Meta meta;
  dynamic message;
  dynamic success;

  CaninesModel({
    required this.data,
    required this.links,
    required this.meta,
    required this.message,
    required this.success,
  });

  factory CaninesModel.fromJson(Map<String, dynamic> json) => CaninesModel(
        data: List<CanineData>.from(
            json["data"].map((x) => CanineData.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
        message: json["message"],
        success: json["success"],
      );
}

class CanineData {
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
  DatumRelationships relationships;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  CanineData({
    required this.id,
    required this.name,
    required this.gender,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.age,
    this.studParams,
    required this.isPublic,
    required this.isPedigree,
    required this.slug,
    required this.relationships,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory CanineData.fromJson(Map<String, dynamic> json) => CanineData(
        id: json["id"],
        name: json["name"],
        gender: json["gender"],
        address: json["address"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        age: json["age"],
        studParams: json["stud_params"] == null
            ? null
            : StudParams.fromJson(json["stud_params"]),
        isPublic: json["is_public"],
        isPedigree: json["is_pedigree"],
        slug: json["slug"],
        relationships: DatumRelationships.fromJson(json["relationships"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );
}

class DatumRelationships {
  dynamic breed;
  dynamic state;
  dynamic city;
  Owner owner;
  List<String> pictures;

  DatumRelationships({
    required this.breed,
    required this.state,
    required this.city,
    required this.owner,
    required this.pictures,
  });

  factory DatumRelationships.fromJson(Map<String, dynamic> json) =>
      DatumRelationships(
        breed: json["breed"],
        state: json["state"],
        city: json["city"],
        owner: Owner.fromJson(json["owner"]),
        pictures: List<String>.from(json["pictures"].map((x) => x)),
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

  factory OwnerRelationships.fromJson(Map<String, dynamic> json) =>
      OwnerRelationships(
        country: json["country"],
        profileImage: json["profile_image"],
      );
}

class StudParams {
  dynamic contractBrief;
  dynamic puppyDealAmount;
  dynamic noPuppyDealAmount;

  StudParams({
    required this.contractBrief,
    required this.puppyDealAmount,
    required this.noPuppyDealAmount,
  });

  factory StudParams.fromJson(Map<String, dynamic> json) => StudParams(
        contractBrief: json["contract_brief"],
        puppyDealAmount: json["puppy_deal_amount"],
        noPuppyDealAmount: json["no_puppy_deal_amount"],
      );
}

class Links {
  dynamic first;
  dynamic last;
  dynamic prev;
  dynamic next;

  Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );
}

class Meta {
  dynamic currentPage;
  dynamic from;
  dynamic lastPage;
  List<Link> links;
  dynamic path;
  dynamic perPage;
  dynamic to;
  dynamic total;

  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );
}

class Link {
  dynamic url;
  dynamic label;
  dynamic active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );
}
