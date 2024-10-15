// To parse this JSON data, do
//
//     final placePredictionModel = placePredictionModelFromJson(jsonString);

import 'dart:convert';

PlacePredictionModel placePredictionModelFromJson(String str) =>
    PlacePredictionModel.fromJson(json.decode(str));

class PlacePredictionModel {
  List<Prediction> predictions;
  dynamic status;

  PlacePredictionModel({
    required this.predictions,
    required this.status,
  });

  factory PlacePredictionModel.fromJson(Map<String, dynamic> json) =>
      PlacePredictionModel(
        predictions: List<Prediction>.from(
            json["predictions"].map((x) => Prediction.fromJson(x))),
        status: json["status"],
      );
}

class Prediction {
  dynamic description;
  dynamic placeId;
  dynamic reference;

  Prediction({
    required this.description,
    required this.placeId,
    required this.reference,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
        description: json["description"],
        placeId: json["place_id"],
        reference: json["reference"],
      );
}
