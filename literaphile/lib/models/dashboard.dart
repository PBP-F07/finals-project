// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Member> welcomeFromJson(String str) =>
    List<Member>.from(json.decode(str).map((x) => Member.fromJson(x)));

String welcomeToJson(List<Member> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Member {
  String model;
  int pk;
  Fields fields;

  Member({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  int user;
  String bio;

  Fields({
    required this.user,
    required this.bio,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        bio: json["bio"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "bio": bio,
      };
}
