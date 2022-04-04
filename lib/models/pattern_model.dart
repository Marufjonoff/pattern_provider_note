// To parse this JSON data, do
//
//     final patternApi = patternApiFromJson(jsonString);

import 'dart:convert';

List<PatternApi> patternApiFromJson(String str) => List<PatternApi>.from(json.decode(str).map((x) => PatternApi.fromJson(x)));

String patternApiToJson(List<PatternApi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PatternApi {
  PatternApi({
    required this.name,
    required this.title,
    required this.body,
    required this.dateTime,
    required this.id,
  });

  String name;
  String title;
  String body;
  String dateTime;
  String id;

  factory PatternApi.fromJson(Map<String, dynamic> json) => PatternApi(
    name: json["name"],
    title: json["title"],
    body: json["body"],
    dateTime: json["dateTime"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "title": title,
    "body": body,
    "dateTime": dateTime,
    "id": id,
  };
}
