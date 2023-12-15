import 'dart:convert';
import 'package:e_complaint/models/openai.dart';
import 'package:http/http.dart' as http;

class ChatbotService {
  static Future<AiModel> getRecommendation({
    required String question,
    required String jwt,
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
      var url = Uri.parse('http://34.128.69.15:8000/ai');

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $jwt"
      };

      final data = jsonEncode({"message": question});

      var response = await http.post(
        url,
        headers: headers,
        body: data,
      );

      if (response.statusCode == 200) {
        aiData = aiModelFromJson(response.body);
      }
    } catch (e) {
      throw Exception('Error occured when sending request $e');
    }
    return aiData;
  }
}
