// To parse this JSON data, do
//
//     final discussion = discussionFromJson(jsonString);

import 'dart:convert';

List<Discussion> discussionFromJson(String str) => List<Discussion>.from(json.decode(str).map((x) => Discussion.fromJson(x)));

String discussionToJson(List<Discussion> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Discussion {
  String model;
  int pk;
  Fields fields;

  Discussion({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Discussion.fromJson(Map<String, dynamic> json) => Discussion(
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
  int book;
  String comment;
  String user;
  String dateAdded;

  Fields({
    required this.book,
    required this.comment,
    required this.user,
    required this.dateAdded,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    book: json["book"],
    comment: json["comment"],
    user: json["user"],
    dateAdded: json["date_added"],
  );

  Map<String, dynamic> toJson() => {
    "book": book,
    "comment": comment,
    "user": user,
    "date_added": dateAdded,
  };
}
