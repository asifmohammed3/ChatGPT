import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:chat_gpt/constants/api_consts.dart';
import 'package:chat_gpt/models/chat_model.dart';
import 'package:chat_gpt/models/models_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<List<ModelsModel>> getModels() async {
    try {
      print("$BASE_URL/models");
      var response = await http.get(Uri.parse("$BASE_URL/models"),
          headers: {'Authorization': 'Bearer $API_KEY'});

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }
      print('jsonResponse----- : $jsonResponse');

      List temp = [];
      for (var value in jsonResponse['data']) {
        temp.add(value);
      }
      return ModelsModel.modelsFromSnapshot(temp);
    } catch (e) {
      print("ERROR-----$e");
      rethrow;
    }
  }

  //send message
  static Future<List<ChatModel>> sendMessage(
      {required String message, required String modelId}) async {
    try {
      print("$BASE_URL/models");
      var response = await http.post(Uri.parse("$BASE_URL/completions"),
          headers: {
            'Authorization': 'Bearer $API_KEY',
            'Content-Type': 'application/json'
          },
          body: jsonEncode({
            "model": modelId,
            "prompt": message,
            "max_tokens": 100,
          }));

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }
      // print('jsonResponse----- : $jsonResponse');

      List<ChatModel> chatList = [];

      if (jsonResponse["choices"].length > 0) {
        // print("jsonResponse--- ${jsonResponse["choices"]}");
        chatList = List.generate(
            jsonResponse['choices'].length,
            (index) => ChatModel(
                msg: jsonResponse['choices'][index]['text'], chatIndex: 1));
      }
      return chatList;
    } catch (e) {
      print("ERROR-----$e");
      rethrow;
    }
  }
}
