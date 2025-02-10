import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  final String _apiKey = dotenv.env['GEMINI_API_KEY'] ?? "";

  Future<String> getRecipe(String ingredients) async {
    final String url =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$_apiKey";

    final Map<String, dynamic> body = {
      "contents": [
        {
          "role": "user",
          "parts": [
            {
              "text":
                  "Elimde şu malzemeler var: $ingredients. Bana yapabileceğim yemekleri listele."
            }
          ]
        }
      ]
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    print("Request URL: $url");
    print("Request Body: ${jsonEncode(body)}");
    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['candidates'][0]['content']['parts'][0]['text'] ??
          "Sonuç bulunamadı.";
    } else {
      return "Hata: ${response.statusCode} - ${response.body}";
    }
  }
}
