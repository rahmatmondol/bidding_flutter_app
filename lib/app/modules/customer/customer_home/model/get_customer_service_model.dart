// // To parse this JSON data, do
// //
// //     final getCustomerServiceModel = getCustomerServiceModelFromJson(jsonString);
//
// import 'dart:convert';
//
// GetCustomerServiceModel getCustomerServiceModelFromJson(String str) => GetCustomerServiceModel.fromJson(json.decode(str));
//
// String getCustomerServiceModelToJson(GetCustomerServiceModel data) => json.encode(data.toJson());
//
// class GetCustomerServiceModel {
//     bool? success;
//     int? status;
//     String? message;
//     Data? data;
//
//     GetCustomerServiceModel({
//         this.success,
//         this.status,
//         this.message,
//         this.data,
//     });
//
//     factory GetCustomerServiceModel.fromJson(Map<String, dynamic> json) => GetCustomerServiceModel(
//         success: json["success"],
//         status: json["status"],
//         message: json["message"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "success": success,
//         "status": status,
//         "message": message,
//         "data": data?.toJson(),
//     };
// }
//
// class Data {
//     List<Datum>? data;
//
//     Data({
//         this.data,
//     });
//
//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//     };
// }
//
// class Datum {
//     int? id;
//     String? name;
//     int? parentId;
//     int? categoryId;
//     int? customerId;
//     List<Zone>? zone;
//     String? price;
//     String? priceType;
//     String? level;
//     String? currency;
//     List<String>? skill;
//     int? commotion;
//     int? providerAmount;
//     String? address;
//     String? status;
//     String? description;
//     String? location;
//     List<Image>? images;
//
//     Datum({
//         this.id,
//         this.name,
//         this.parentId,
//         this.categoryId,
//         this.customerId,
//         this.zone,
//         this.price,
//         this.priceType,
//         this.level,
//         this.currency,
//         this.skill,
//         this.commotion,
//         this.providerAmount,
//         this.address,
//         this.status,
//         this.description,
//         this.location,
//         this.images,
//     });
//
//     factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         name: json["name"],
//         parentId: json["parent_id"],
//         categoryId: json["category_id"],
//         customerId: json["customer_id"],
//         zone: json["zone"] == null ? [] : List<Zone>.from(json["zone"]!.map((x) => Zone.fromJson(x))),
//         price: json["price"],
//         priceType: json["price_type"],
//         level: json["level"],
//         currency: json["currency"],
//         skill: json["skill"] == null ? [] : List<String>.from(json["skill"]!.map((x) => x)),
//         commotion: json["commotion"],
//         providerAmount: json["provider_amount"],
//         address: json["address"],
//         status: json["status"],
//         description: json["description"],
//         location: json["location"],
//         images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "parent_id": parentId,
//         "category_id": categoryId,
//         "customer_id": customerId,
//         "zone": zone == null ? [] : List<dynamic>.from(zone!.map((x) => x.toJson())),
//         "price": price,
//         "price_type": priceType,
//         "level": level,
//         "currency": currency,
//         "skill": skill == null ? [] : List<dynamic>.from(skill!.map((x) => x)),
//         "commotion": commotion,
//         "provider_amount": providerAmount,
//         "address": address,
//         "status": status,
//         "description": description,
//         "location": location,
//         "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
//     };
// }
//
// class Image {
//     int? id;
//     int? serviceId;
//     String? path;
//
//     Image({
//         this.id,
//         this.serviceId,
//         this.path,
//     });
//
//     factory Image.fromJson(Map<String, dynamic> json) => Image(
//         id: json["id"],
//         serviceId: json["service_id"],
//         path: json["path"],
//     );
//
//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "service_id": serviceId,
//         "path": path,
//     };
// }
//
// class Zone {
//     int? id;
//     String? name;
//
//     Zone({
//         this.id,
//         this.name,
//     });
//
//     factory Zone.fromJson(Map<String, dynamic> json) => Zone(
//         id: json["id"],
//         name: json["name"],
//     );
//
//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//     };
// }

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

GetCustomerServiceModel getCustomerServiceModelFromJson(String str) =>
    GetCustomerServiceModel.fromJson(json.decode(str));

String getCustomerServiceModelToJson(GetCustomerServiceModel data) =>
    json.encode(data.toJson());

class GetCustomerServiceModel {
  bool? success;
  int? status;
  String? message;
  List<ServiceData>? data;

  GetCustomerServiceModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory GetCustomerServiceModel.fromJson(Map<String, dynamic> json) =>
      GetCustomerServiceModel(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ServiceData>.from(
                json["data"].map((x) => ServiceData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ServiceData {
  int? id;
  String? title;
  String? slug;
  String? description;
  dynamic price;
  String? location;
  String? latitude;
  String? longitude;
  String? priceType;
  String? currency;
  String? status;
  String? level;
  String? postType;
  DateTime? deadline;
  List<String>? skills;
  int? commission;
  int? isFeatured;
  int? categoryId;
  int? subCategoryId;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ServiceImage>? images;
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
    this.customer,
  });

  factory ServiceData.fromJson(Map<String, dynamic> json) => ServiceData(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        price: json["price"],
        location: json["location"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        priceType: json["priceType"],
        currency: json["currency"],
        status: json["status"],
        level: json["level"],
        postType: json["postType"],
        deadline:
            json["deadline"] == null ? null : DateTime.parse(json["deadline"]),
        skills: json["skills"] == null
            ? []
            : List<String>.from(jsonDecode(json["skills"])),
        commission: json["commission"],
        isFeatured: json["is_featured"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        images: json["images"] == null
            ? []
            : List<ServiceImage>.from(
                json["images"].map((x) => ServiceImage.fromJson(x))),
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "description": description,
        "price": price,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
        "priceType": priceType,
        "currency": currency,
        "status": status,
        "level": level,
        "postType": postType,
        "deadline": deadline?.toIso8601String(),
        "skills":
            skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
        "commission": commission,
        "is_featured": isFeatured,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "customer": customer?.toJson(),
      };
}

class Customer {
  int? id;
  String? name;
  String? mobile;
  String? email;
  DateTime? emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

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
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "email": email,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class ServiceImage {
  int? id;
  String? name;
  String? path;
  int? serviceId;
  DateTime? createdAt;
  DateTime? updatedAt;

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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "path": path,
        "service_id": serviceId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
