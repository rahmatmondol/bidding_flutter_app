// To parse this JSON data, do
//
//     final cateegoryModel = cateegoryModelFromJson(jsonString);

import 'dart:convert';

CateegoryModel cateegoryModelFromJson(String str) =>
    CateegoryModel.fromJson(json.decode(str));

String cateegoryModelToJson(CateegoryModel data) => json.encode(data.toJson());

class CateegoryModel {
  bool? success;
  int? status;
  String? message;
  Data? data;

  CateegoryModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory CateegoryModel.fromJson(Map<String, dynamic> json) => CateegoryModel(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  List<Category>? category;

  Data({
    this.category,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        category: json["category"] == null
            ? []
            : List<Category>.from(
                json["category"]!.map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": category == null
            ? []
            : List<dynamic>.from(category!.map((x) => x.toJson())),
      };
}

class Category {
  int? id;
  int? parentId;
  String? name;
  String? image;
  int? position;
  int? isActive;
  int? isFeatured;
  DateTime? createdAt;
  DateTime? updatedAt;

  Category({
    this.id,
    this.parentId,
    this.name,
    this.image,
    this.position,
    this.isActive,
    this.isFeatured,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        parentId: json["parent_id"],
        name: json["name"],
        image: json["image"],
        position: json["position"],
        isActive: json["is_active"],
        isFeatured: json["is_featured"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "name": name,
        "image": image,
        "position": position,
        "is_active": isActive,
        "is_featured": isFeatured,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
