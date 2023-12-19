// To parse this JSON data, do
//
//     final searchWishlist = searchWishlistFromJson(jsonString);

import 'dart:convert';

SearchWishlist searchWishlistFromJson(String str) => SearchWishlist.fromJson(json.decode(str));

String searchWishlistToJson(SearchWishlist data) => json.encode(data.toJson());

class SearchWishlist {
    String kind;
    String id;
    String etag;
    String selfLink;
    VolumeInfo volumeInfo;
    SaleInfo saleInfo;
    AccessInfo accessInfo;

    SearchWishlist({
        required this.kind,
        required this.id,
        required this.etag,
        required this.selfLink,
        required this.volumeInfo,
        required this.saleInfo,
        required this.accessInfo,
    });

    factory SearchWishlist.fromJson(Map<String, dynamic> json) => SearchWishlist(
        kind: json["kind"]?? 'No Name',
        id: json["id"]?? 'No Name',
        etag: json["etag"]?? 'No Name',
        selfLink: json["selfLink"]?? 'No Name',
        volumeInfo: VolumeInfo.fromJson(json["volumeInfo"]?? {}),
        saleInfo: SaleInfo.fromJson(json["saleInfo"]?? {}),
        accessInfo: AccessInfo.fromJson(json["accessInfo"]?? {})
    );

    Map<String, dynamic> toJson() => {
        "kind": kind,
        "id": id,
        "etag": etag,
        "selfLink": selfLink,
        "volumeInfo": volumeInfo.toJson(),
        "saleInfo": saleInfo.toJson(),
        "accessInfo": accessInfo.toJson(),
    };
}

class AccessInfo {
    String country;
    String viewability;
    bool embeddable;
    bool publicDomain;
    String textToSpeechPermission;
    Epub epub;
    Epub pdf;
    String webReaderLink;
    String accessViewStatus;
    bool quoteSharingAllowed;

    AccessInfo({
        required this.country,
        required this.viewability,
        required this.embeddable,
        required this.publicDomain,
        required this.textToSpeechPermission,
        required this.epub,
        required this.pdf,
        required this.webReaderLink,
        required this.accessViewStatus,
        required this.quoteSharingAllowed,
    });

    factory AccessInfo.fromJson(Map<String, dynamic> json) => AccessInfo(
        country: json["country"]?? 'Default Price',
        viewability: json["viewability"]?? 'Default Price',
        embeddable: json["embeddable"]?? 'Default Price',
        publicDomain: json["publicDomain"]?? 'Default Price',
        textToSpeechPermission: json["textToSpeechPermission"]?? 'Default Price',
        epub: Epub.fromJson(json["epub"]??{}),
        pdf: Epub.fromJson(json["pdf"]??{}),
        webReaderLink: json["webReaderLink"]?? 'Default Price',
        accessViewStatus: json["accessViewStatus"]?? 'Default Price',
        quoteSharingAllowed: json["quoteSharingAllowed"]?? 'Default Price',
    );

    Map<String, dynamic> toJson() => {
        "country": country,
        "viewability": viewability,
        "embeddable": embeddable,
        "publicDomain": publicDomain,
        "textToSpeechPermission": textToSpeechPermission,
        "epub": epub.toJson(),
        "pdf": pdf.toJson(),
        "webReaderLink": webReaderLink,
        "accessViewStatus": accessViewStatus,
        "quoteSharingAllowed": quoteSharingAllowed,
    };
}

class Epub {
    bool isAvailable;

    Epub({
        required this.isAvailable,
    });

    factory Epub.fromJson(Map<String, dynamic> json) => Epub(
        isAvailable: json["isAvailable"]?? 'Default Price',
    );

    Map<String, dynamic> toJson() => {
        "isAvailable": isAvailable,
    };
}

class SaleInfo {
    String country;
    String saleability;
    bool isEbook;

    SaleInfo({
        required this.country,
        required this.saleability,
        required this.isEbook,
    });

    factory SaleInfo.fromJson(Map<String, dynamic> json) => SaleInfo(
        country: json["country"]?? 'Default Price',
        saleability: json["saleability"]?? 'Default Price',
        isEbook: json["isEbook"]?? 'Default Price',
    );

    Map<String, dynamic> toJson() => {
        "country": country,
        "saleability": saleability,
        "isEbook": isEbook,
    };
}

class VolumeInfo {
    String title;
    String subtitle;
    List<String> authors;
    String publisher;
    // DateTime publishedDate;
    List<IndustryIdentifier> industryIdentifiers;
    // ReadingModes readingModes;
    int pageCount;
    int printedPageCount;
    // Dimensions dimensions;
    String printType;
    List<String> categories;
    String contentVersion;
    // ImageLinks imageLinks;
    String language;
    String previewLink;
    String infoLink;
    String canonicalVolumeLink;

    VolumeInfo({
        required this.title,
        required this.subtitle,
        required this.authors,
        required this.publisher,
        // required this.publishedDate,
        required this.industryIdentifiers,
        // required this.readingModes,
        required this.pageCount,
        required this.printedPageCount,
        // required this.dimensions,
        required this.printType,
        required this.categories,
        required this.contentVersion,
        // required this.imageLinks,
        required this.language,
        required this.previewLink,
        required this.infoLink,
        required this.canonicalVolumeLink,
    });

    factory VolumeInfo.fromJson(Map<String, dynamic> json) {
 
    return VolumeInfo(
      title: json["title"] ?? 'No Title',
      subtitle: json["subtitle"] ?? 'No Subtitle',
      authors: List<String>.from(json["authors"] ?? []) ?? [],
      publisher: json["publisher"] ?? 'No Publisher',
      // publishedDate: json["publishedDate"] != null ? DateTime.parse(json["publishedDate"]) : DateTime.now(),
      industryIdentifiers: json["industryIdentifiers"] != null
          ? List<IndustryIdentifier>.from(json["industryIdentifiers"].map((x) => IndustryIdentifier.fromJson(x))) ?? []
          : [],
      // readingModes: ReadingModes.fromJson(json["readingModes"]) ?? ReadingModes(),
      pageCount: json["pageCount"] ?? 0,
      printedPageCount: json["printedPageCount"] ?? 0,
      // dimensions: Dimensions.fromJson(json["dimensions"]) ?? Dimensions(),
      printType: json["printType"],
      categories: json["categories"] != null
          ? List<String>.from(json["categories"].map((x) => x)) ?? []
          : [],
      contentVersion: json["contentVersion"],
      // imageLinks: ImageLinks.fromJson(json["imageLinks"]) ?? ImageLinks(),
      language: json["language"],
      previewLink: json["previewLink"],
      infoLink: json["infoLink"],
      canonicalVolumeLink: json["canonicalVolumeLink"],
    );
  
}


    Map<String, dynamic> toJson() => {
        "title": title,
        "subtitle": subtitle,
        "authors": List<dynamic>.from(authors.map((x) => x)),
        "publisher": publisher,
        // "publishedDate": "${publishedDate.year.toString().padLeft(4, '0')}-${publishedDate.month.toString().padLeft(2, '0')}-${publishedDate.day.toString().padLeft(2, '0')}",
        "industryIdentifiers": List<dynamic>.from(industryIdentifiers.map((x) => x.toJson())),
        // "readingModes": readingModes.toJson(),
        "pageCount": pageCount,
        "printedPageCount": printedPageCount,
        // "dimensions": dimensions.toJson(),
        "printType": printType,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "contentVersion": contentVersion,
        // "imageLinks": imageLinks.toJson(),
        "language": language,
        "previewLink": previewLink,
        "infoLink": infoLink,
        "canonicalVolumeLink": canonicalVolumeLink,
    };
}

class Dimensions {
    String height;

    Dimensions({
        required this.height,
    });

    factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        height: json["height"]?? 'Default Price',
    );

    Map<String, dynamic> toJson() => {
        "height": height,
    };
}

class ImageLinks {
    String smallThumbnail;
    String thumbnail;
    String small;
    String medium;
    String large;
    String extraLarge;

    ImageLinks({
        required this.smallThumbnail,
        required this.thumbnail,
        required this.small,
        required this.medium,
        required this.large,
        required this.extraLarge,
    });

    factory ImageLinks.fromJson(Map<String, dynamic> json) => ImageLinks(
        smallThumbnail: json["smallThumbnail"]?? 'No Name',
        thumbnail: json["thumbnail"]?? 'No Name',
        small: json["small"]?? 'No Name',
        medium: json["medium"]?? 'No Name',
        large: json["large"]?? 'No Name',
        extraLarge: json["extraLarge"]?? 'No Name',
    );

    Map<String, dynamic> toJson() => {
        "smallThumbnail": smallThumbnail,
        "thumbnail": thumbnail,
        "small": small,
        "medium": medium,
        "large": large,
        "extraLarge": extraLarge,
    };
}

class IndustryIdentifier {
    String type;
    String identifier;

    IndustryIdentifier({
        required this.type,
        required this.identifier,
    });

    factory IndustryIdentifier.fromJson(Map<String, dynamic> json) => IndustryIdentifier(
        type: json["type"]?? 'No Name',
        identifier: json["identifier"]?? 'No Name',
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "identifier": identifier,
    };
}

class ReadingModes {
    bool text;
    bool image;

    ReadingModes({
        required this.text,
        required this.image,
    });

    factory ReadingModes.fromJson(Map<String, dynamic> json) => ReadingModes(
        text: json["text"]?? 'No Name',
        image: json["image"]?? 'No Name',
    );

    Map<String, dynamic> toJson() => {
        "text": text,
        "image": image,
    };
}
