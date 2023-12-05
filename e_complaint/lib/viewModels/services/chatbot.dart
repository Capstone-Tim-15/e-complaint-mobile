import 'dart:convert';
import 'package:e_complaint/models/openai.dart';
import 'package:e_complaint/views/Chatbot/components/constants.dart';
import 'package:http/http.dart' as http;

class ChatbotService {
  static Future<AiModel> getRecommendation({
    required String question,
  }) async {
    late AiModel aiData = AiModel(
      meta: Meta(success: true, message: ""),
      results: Results(
        complaint: "",
        recommendation: "",
        timestamp: DateTime.timestamp(),
      ),
    );

    try {
      var url = Uri.parse('https://api.openai.com/v1/chat/completions');

      Map<String, String> headers = {
        "Content-Type": "application/json",
        // BEARER MASI PERLU DIUBAH
        "Authorization": "Bearer "
      };

      final data = jsonEncode({
       "message": question
      });

      var response = await http.post(
        url,
        headers: headers,
        body: data,
      );

      if (response.statusCode == 200) {
        aiData = aiModelFromJson(response.body);
      }
    } catch (e) {
      throw Exception('Error occured when sending request');
    }
    return aiData;
  }
}
