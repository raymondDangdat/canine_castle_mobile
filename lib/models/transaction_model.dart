// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'dart:convert';

TransactionModel transactionModelFromJson(String str) =>
    TransactionModel.fromJson(json.decode(str));

class TransactionModel {
  List<TransactionData> data;
  Links links;
  Meta meta;
  dynamic message;
  dynamic success;

  TransactionModel({
    required this.data,
    required this.links,
    required this.meta,
    required this.message,
    required this.success,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        data: List<TransactionData>.from(
            json["data"].map((x) => TransactionData.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
        message: json["message"],
        success: json["success"],
      );
}

class TransactionData {
  dynamic id;
  dynamic type;
  dynamic amount;
  dynamic reference;
  dynamic description;
  dynamic gateway;
  dynamic status;
  dynamic charges;
  dynamic location;
  Payload? payload;
  dynamic slug;
  Relationships relationships;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  TransactionData({
    required this.id,
    required this.type,
    required this.amount,
    required this.reference,
    required this.description,
    required this.gateway,
    required this.status,
    required this.charges,
    required this.location,
    required this.payload,
    required this.slug,
    required this.relationships,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) =>
      TransactionData(
        id: json["id"],
        type: json["type"],
        amount: json["amount"],
        reference: json["reference"],
        description: json["description"],
        gateway: json["gateway"],
        status: json["status"],
        charges: json["charges"],
        location: json["location"],
        payload: json["payload"] == null ? null : Payload.fromJson(json["payload"]),
        slug: json["slug"],
        relationships: Relationships.fromJson(json["relationships"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );
}

class Payload {
  Cookies cookies;
  Cookies transferStats;

  Payload({
    required this.cookies,
    required this.transferStats,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        cookies: Cookies.fromJson(json["cookies"]),
        transferStats: Cookies.fromJson(json["transferStats"]),
      );
}

class Cookies {
  Cookies();

  factory Cookies.fromJson(Map<String, dynamic> json) => Cookies();
}

class Relationships {
  Wallet wallet;

  Relationships({
    required this.wallet,
  });

  factory Relationships.fromJson(Map<String, dynamic> json) => Relationships(
        wallet: Wallet.fromJson(json["wallet"]),
      );
}

class Wallet {
  dynamic id;
  dynamic tag;
  dynamic balance;
  dynamic currency;

  Wallet({
    required this.id,
    required this.tag,
    required this.balance,
    required this.currency,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["id"],
        tag: json["tag"],
        balance: json["balance"],
        currency: json["currency"],
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
