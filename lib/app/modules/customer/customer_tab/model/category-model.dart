// To parse this JSON data, do
//
//     final cCatgoryModel = cCatgoryModelFromJson(jsonString);

import 'dart:convert';

CCatgoryModel cCatgoryModelFromJson(String str) => CCatgoryModel.fromJson(json.decode(str));

String cCatgoryModelToJson(CCatgoryModel data) => json.encode(data.toJson());

class CCatgoryModel {
    String? message;
    int? status;
    bool? success;
    List<Datum>? data;

    CCatgoryModel({
        this.message,
        this.status,
        this.success,
        this.data,
    });

    factory CCatgoryModel.fromJson(Map<String, dynamic> json) => CCatgoryModel(
        message: json["message"],
        status: json["status"],
        success: json["success"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? id;
    String? name;
    String? slug;
    String? description;
    String? image;
    Status? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    Datum({
        this.id,
        this.name,
        this.slug,
        this.description,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        image: json["image"],
        status: statusValues.map[json["status"]]!,
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "description": description,
        "image": image,
        "status": statusValues.reverse[status],
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

enum Status {
    ACTIVE,
    INACTIVE
}

final statusValues = EnumValues({
    "Active": Status.ACTIVE,
    "Inactive": Status.INACTIVE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
