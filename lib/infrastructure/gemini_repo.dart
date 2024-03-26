
import 'package:code_geeks/domain/gemini_model.dart';
import 'package:code_geeks/infrastructure/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GeminiRepo{ 
  static Future<String> geminiTextGenerationRepo(List<GeminiMessageModel> previousMessages)async{
    
    try{
      Dio dio = Dio();

    final response = await dio.post('https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-pro:generateContent?key=$api_key',
    
    data: {
  "contents": previousMessages.map((e) => e.toMap()).toList(),
  "generationConfig": {
    "temperature": 0.9,
    "topK": 1,
    "topP": 1,
    "maxOutputTokens": 2048,
    "stopSequences": []
  },
  "safetySettings": [
    {
      "category": "HARM_CATEGORY_HARASSMENT",
      "threshold": "BLOCK_MEDIUM_AND_ABOVE"
    },
    {
      "category": "HARM_CATEGORY_HATE_SPEECH",
      "threshold": "BLOCK_MEDIUM_AND_ABOVE"
    },
    {
      "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
      "threshold": "BLOCK_MEDIUM_AND_ABOVE"
    },
    {
      "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
      "threshold": "BLOCK_MEDIUM_AND_ABOVE"
    }
  ]
}

    );
    if(response.statusCode!>=200 && response.statusCode!<300){
      return response.data['candidates'].first['content']['parts'].first['text'];
    }
    return '';
    }
    catch(e){
      debugPrint(e.toString());
      return '';
    }
  } 
}