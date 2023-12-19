// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) =>
    List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  String model;
  int pk;
  Fields fields;

  Book({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
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
  String title;
  String author;
  String description;
  String image;
  String yearOfRelease;
  int amount;
  int borrowedBy;
  DateTime borrowedDate;
  DateTime returnDate;
  String isBorrowed;

  Fields({
    required this.user,
    required this.title,
    required this.author,
    required this.description,
    required this.image,
    required this.yearOfRelease,
    required this.amount,
    required this.borrowedBy,
    required this.borrowedDate,
    required this.returnDate,
    required this.isBorrowed,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"] ?? 0,
        title: json["title"] ?? "Unknown",
        author: json["author"] ?? "Unknown",
        description: json["description"] ?? "Unknown",
        image: json["image"] ?? "No image",
        yearOfRelease: json["year_of_release"] ?? "Unknown",
        amount: json["amount"] ?? 0,
        borrowedBy: json["borrowed_by"] ?? 0,
        borrowedDate: DateTime.parse(json["borrowed_date"] ?? "0000-00-00 00:00:00"),
        returnDate: DateTime.parse(json["return_date"] ?? "0000-00-00 00:00:00"),
        isBorrowed: json["is_borrowed"] ?? "Unknown",
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "title": title,
        "author": author,
        "description": description,
        "image": image,
        "year_of_release": yearOfRelease,
        "amount": amount,
        "borrowed_by": borrowedBy,
        "borrowed_date":
            "${borrowedDate.year.toString().padLeft(4, '0')}-${borrowedDate.month.toString().padLeft(2, '0')}-${borrowedDate.day.toString().padLeft(2, '0')}",
        "return_date":
            "${returnDate.year.toString().padLeft(4, '0')}-${returnDate.month.toString().padLeft(2, '0')}-${returnDate.day.toString().padLeft(2, '0')}",
        "is_borrowed": isBorrowed,
      };
}
