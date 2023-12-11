// To parse this JSON data, do
//
//     final wishlist = wishlistFromJson(jsonString);

import 'dart:convert';

List<Wishlist> wishlistFromJson(String str) => List<Wishlist>.from(json.decode(str).map((x) => Wishlist.fromJson(x)));

String wishlistToJson(List<Wishlist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Wishlist {
    String model;
    int pk;
    Fields fields;

    Wishlist({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
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

    Fields({
        required this.user,
        required this.title,
        required this.author,
        required this.description,
        required this.image,
        required this.yearOfRelease,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        title: json["title"],
        author: json["author"],
        description: json["description"],
        image: json["image"],
        yearOfRelease: json["year_of_release"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "title": title,
        "author": author,
        "description": description,
        "image": image,
        "year_of_release": yearOfRelease,
    };
}