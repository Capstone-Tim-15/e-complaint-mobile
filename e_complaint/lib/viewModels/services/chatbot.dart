import 'dart:convert';
import 'package:e_complaint/models/chatbot.dart';
import 'package:e_complaint/viewModels/helpers/apikey.dart';
import 'package:http/http.dart' as http;

class ChatbotService {
  static Future<GptData> getGuide({
    required String question,
  }) async {
    late GptData gptData = GptData(
      id: "",
      object: "",
      created: 0,
      model: "",
      choices: [],
      usage: Usage(promptTokens: 0, completionTokens: 0, totalTokens: 0),
    );

    try {
      var url = Uri.parse('https://api.openai.com/v1/chat/completions');

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey"
      };

      String promptData = '';

      final data = jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            "role": "user",
            "content": promptData,
          }
        ],
        "temperature": 0.7,
        "max_tokens": 1000
      });
      // print("Print sebelum response");
      var response = await http.post(
        url,
        headers: headers,
        body: data,
      );

      if (response.statusCode == 200) {
        gptData = gptDataFromJson(response.body);
      }
    } catch (e) {
      throw Exception('Error occured when sending request');
    }
    return gptData;
  }
}
