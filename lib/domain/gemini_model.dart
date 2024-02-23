// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GeminiMessageModel {
  final String role;
  final List<GeminiPartModel> parts;
  GeminiMessageModel({
    required this.role,
    required this.parts,
  });

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'parts': parts.map((x) => x.toMap()).toList(),
    };
  }

  factory GeminiMessageModel.fromMap(Map<String, dynamic> map) {
    return GeminiMessageModel(
      role: map['role'] ?? '',
      parts: List<GeminiPartModel>.from(
          map['parts']?.map((x) => GeminiPartModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory GeminiMessageModel.fromJson(String source) =>
      GeminiMessageModel.fromMap(json.decode(source));
}

class GeminiPartModel {
  final String text;
  GeminiPartModel({
    required this.text,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
    };
  }

  factory GeminiPartModel.fromMap(Map<String, dynamic> map) {
    return GeminiPartModel(
      text: map['text'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory GeminiPartModel.fromJson(String source) =>
      GeminiPartModel.fromMap(json.decode(source));
}