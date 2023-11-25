import 'dart:convert';
import 'package:e_complaint/models/openai.dart';
import 'package:e_complaint/views/Chatbot/constants.dart';
import 'package:http/http.dart' as http;

class ChatbotService {
  static Future<GptData> getAnswer({
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

      String promptData =
          '[{"id":1,"title":"Halo","answer":"Selamat datang di Gov-Complaint Batam. Saya adalah asisten virtual pertama anda. Bagaimana saya bisa membantu anda?"},{"id":2,"title":"Apa saja kategori pengaduan yang tersedia?","answer":"Pilihan kategori yang terserdia: 1. Jalan dan Transportasi. 2. Lingkungan dan Sampah. 3. Administrasi Publik. 4. PDAM dan pasokan air. 5. Keamanan dan kriminalitas. 6. Pendidikan. 7. Pariwisata. 8. Keuangan dan Pajak. 9. Pengaduan Publik"},{"id":3,"title":"Bagaimana melacak status pengaduan saya","answer":"Cara melacak : 1. Login. 2. Masuk ke menu pengaduan. 3. Lihat detail pengaduan."},{"id":4,"title":"Minor Burns","answer":"/guide3"}] Kamu adalah chatbot. Sesuaikan answer dengan title dari "$question". Output yang dihasilkan hanya ada 1 data answer sesuai dengan title dari "$question". Tulis ulang semua answer dari title "$question" dan buat output menjadi rapih ';

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
