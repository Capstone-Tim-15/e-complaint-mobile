// To parse this JSON data, do
//
//     final aiModel = aiModelFromJson(jsonString);

import 'dart:convert';

AiModel aiModelFromJson(String str) => AiModel.fromJson(json.decode(str));

String aiModelToJson(AiModel data) => json.encode(data.toJson());

class AiModel {
  Meta meta;
  Results results;

  AiModel({
    required this.meta,
    required this.results,
  });

  factory AiModel.fromJson(Map<String, dynamic> json) => AiModel(
        meta: Meta.fromJson(json["meta"]),
        results: Results.fromJson(json["results"]),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "results": results.toJson(),
      };
}

class Meta {
  bool success;
  String message;

  Meta({
    required this.success,
    required this.message,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}

class Results {
  String complaint;
  String recommendation;
  DateTime timestamp;

  Results({
    required this.complaint,
    required this.recommendation,
    required this.timestamp,
  });

  String get text => recommendation;  

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        complaint: json["complaint"],
        recommendation: json["recommendation"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "complaint": complaint,
        "recommendation": recommendation,
        "timestamp": timestamp.toIso8601String(),
      };
}
