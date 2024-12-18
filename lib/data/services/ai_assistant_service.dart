import 'dart:convert';

import 'package:ai_assistant_app/data/constants/end_points.dart';
import 'package:ai_assistant_app/data/interface/open_ai_interface.dart';
import 'package:ai_assistant_app/data/key/api_keys.dart';
import 'package:http/http.dart' as http;

final class AiAssistantService implements AiAssistantInterface {
  @override
  Future<String> getAIResponse(String query) async {
    final response = await http.post(
      Uri.parse(ai_model_endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $ai_model_key',
      },
      body: jsonEncode({
        'model': 'openai-community/gpt2',
        'inputs': query,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['generated_text'];
    } else {
      throw Exception('Failed to fetch AI response');
    }
  }
}
