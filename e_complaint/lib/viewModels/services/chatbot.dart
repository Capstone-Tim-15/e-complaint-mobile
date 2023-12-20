import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:e_complaint/models/openai.dart';
import 'package:flutter/material.dart';

class ChatbotServiceProvider extends ChangeNotifier {
  AiModel _aiData = AiModel(
    meta: Meta(success: true, message: ""),
    results: Results(
      complaint: "",
      recommendation: "",
      timestamp: DateTime.timestamp(),
    ),
  );

  AiModel get aiData => _aiData;

  Future<void> getRecommendation({
    required String question,
    required String jwt,
  }) async {
    try {
      var url = 'http://34.128.69.15:8000/ai';

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $jwt"
      };

      var dio = Dio();
      var response = await dio.post(
        url,
        data: {
          'message': question,
        },
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        _aiData = aiModelFromJson(jsonEncode(response.data));
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Error occured when sending request $e');
    }
  }
}
