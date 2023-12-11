// To parse this JSON data, do
//
//     final books = booksFromJson(jsonString);

import 'dart:convert';

List<Books> booksFromJson(String str) => List<Books>.from(json.decode(str).map((x) => Books.fromJson(x)));

String booksToJson(List<Books> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Books {
    String model;
    int pk;
    Fields fields;

    Books({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Books.fromJson(Map<String, dynamic> json) => Books(
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
    String title;
    String author;
    String description;
    String image;
    String yearOfRelease;
    int amount;
    int? borrowedBy;
    DateTime? borrowedDate;
    DateTime? returnDate;
    String? isBorrowed;

    Fields({
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
        title: json["title"],
        author: json["author"],
        description: json["description"],
        image: json["image"],
        yearOfRelease: json["year_of_release"],
        amount: json["amount"],
        borrowedBy: json["borrowed_by"],
        borrowedDate: json["borrowed_date"] == null ? null : DateTime.parse(json["borrowed_date"]),
        returnDate: json["return_date"] == null ? null : DateTime.parse(json["return_date"]),
        isBorrowed: json["is_borrowed"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "description": description,
        "image": image,
        "year_of_release": yearOfRelease,
        "amount": amount,
        "borrowed_by": borrowedBy,
        "borrowed_date": "${borrowedDate!.year.toString().padLeft(4, '0')}-${borrowedDate!.month.toString().padLeft(2, '0')}-${borrowedDate!.day.toString().padLeft(2, '0')}",
        "return_date": "${returnDate!.year.toString().padLeft(4, '0')}-${returnDate!.month.toString().padLeft(2, '0')}-${returnDate!.day.toString().padLeft(2, '0')}",
        "is_borrowed": isBorrowed,
    };
}
