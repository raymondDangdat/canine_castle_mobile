// To parse this JSON data, do
//
//     final subscriptionPlanModel = subscriptionPlanModelFromJson(jsonString);

import 'dart:convert';

SubscriptionPlanModel subscriptionPlanModelFromJson(String str) =>
    SubscriptionPlanModel.fromJson(json.decode(str));

class SubscriptionPlanModel {
  List<SubscriptionPlanData> data;
  Links links;
  Meta meta;
  dynamic message;
  dynamic success;

  SubscriptionPlanModel({
    required this.data,
    required this.links,
    required this.meta,
    required this.message,
    required this.success,
  });

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionPlanModel(
        data: List<SubscriptionPlanData>.from(
            json["data"].map((x) => SubscriptionPlanData.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
        message: json["message"],
        success: json["success"],
      );
}

class SubscriptionPlanData {
  dynamic id;
  dynamic name;
  dynamic description;
  List<dynamic> features;
  dynamic cost;
  dynamic userType;
  dynamic slug;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  SubscriptionPlanData({
    required this.id,
    required this.name,
    required this.description,
    required this.features,
    required this.cost,
    required this.userType,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory SubscriptionPlanData.fromJson(Map<String, dynamic> json) =>
      SubscriptionPlanData(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        features: List<String>.from(json["features"].map((x) => x)),
        cost: json["cost"],
        userType: json["user_type"],
        slug: json["slug"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
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
