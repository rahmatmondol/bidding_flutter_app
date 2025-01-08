import 'dart:convert';

class CustomerServiceDetailsModel {
  bool? success;
  int? status;
  String? message;
  ServiceData? data;

  CustomerServiceDetailsModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory CustomerServiceDetailsModel.fromJson(Map<String, dynamic> json) =>
      CustomerServiceDetailsModel(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : ServiceData.fromJson(json["data"]),
      );
}

class ServiceData {
  int? id;
  String? title;
  String? slug;
  String? description;
  double? price;
  String? location;
  String? latitude;
  String? longitude;
  String? priceType;
  String? currency;
  String? status;
  String? level;
  String? postType;
  String? deadline;
  List<String>? skills;
  int? commission;
  int? isFeatured;
  int? categoryId;
  int? subCategoryId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  List<ServiceImage>? images;
  Category? category;
  Customer? customer;

  ServiceData({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.price,
    this.location,
    this.latitude,
    this.longitude,
    this.priceType,
    this.currency,
    this.status,
    this.level,
    this.postType,
    this.deadline,
    this.skills,
    this.commission,
    this.isFeatured,
    this.categoryId,
    this.subCategoryId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.images,
    this.category,
    this.customer,
  });

  factory ServiceData.fromJson(Map<String, dynamic> json) {
    // Parse skills from JSON string
    List<String> parseSkills(dynamic skillsData) {
      if (skillsData == null) return [];
      try {
        if (skillsData is String) {
          final List<dynamic> decoded = jsonDecode(skillsData);
          return List<String>.from(decoded);
        } else if (skillsData is List) {
          return List<String>.from(skillsData);
        }
      } catch (e) {
        print("Error parsing skills: $e");
      }
      return [];
    }

    return ServiceData(
      id: json["id"],
      title: json["title"],
      slug: json["slug"],
      description: json["description"],
      price: json["price"]?.toDouble(),
      location: json["location"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      priceType: json["priceType"],
      currency: json["currency"],
      status: json["status"],
      level: json["level"],
      postType: json["postType"],
      deadline: json["deadline"],
      skills: parseSkills(json["skills"]),
      commission: json["commission"],
      isFeatured: json["is_featured"],
      categoryId: json["category_id"],
      subCategoryId: json["sub_category_id"],
      userId: json["user_id"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      images: json["images"] == null
          ? []
          : List<ServiceImage>.from(
              json["images"].map((x) => ServiceImage.fromJson(x))),
      category:
          json["category"] == null ? null : Category.fromJson(json["category"]),
      customer:
          json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    );
  }
}

class ServiceImage {
  int? id;
  String? name;
  String? path;
  int? serviceId;
  String? createdAt;
  String? updatedAt;

  ServiceImage({
    this.id,
    this.name,
    this.path,
    this.serviceId,
    this.createdAt,
    this.updatedAt,
  });

  factory ServiceImage.fromJson(Map<String, dynamic> json) => ServiceImage(
        id: json["id"],
        name: json["name"],
        path: json["path"],
        serviceId: json["service_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}

class Category {
  int? id;
  String? name;
  String? slug;
  String? description;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;

  Category({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        image: json["image"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}

class Customer {
  int? id;
  String? name;
  String? mobile;
  String? email;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  Customer({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}
