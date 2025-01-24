// // services_model.dart
//
// class Providerservicemodel {
//   final bool? success;
//   final int? status;
//   final String? message;
//   final List<Service>? data;
//
//   Providerservicemodel({
//     this.success,
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   factory Providerservicemodel.fromJson(Map<String, dynamic> json) =>
//       Providerservicemodel(
//         success: json["success"],
//         status: json["status"],
//         message: json["message"],
//         data: json["data"] == null
//             ? []
//             : List<Service>.from(json["data"]!.map((x) => Service.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "status": status,
//         "message": message,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }
//
// class Service {
//   final int? id;
//   final String? title;
//   final String? slug;
//   final String? description;
//   final double? price;
//   final String? location;
//   final String? latitude;
//   final String? longitude;
//   final String? priceType;
//   final String? currency;
//   final String? status;
//   final String? level;
//   final String? postType;
//   final String? deadline;
//   final String? skills;
//   final int? commission;
//   final int? isFeatured;
//   final int? categoryId;
//   final int? subCategoryId;
//   final int? userId;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final List<ServiceImage>? images;
//   final Customer? customer;
//
//   Service({
//     this.id,
//     this.title,
//     this.slug,
//     this.description,
//     this.price,
//     this.location,
//     this.latitude,
//     this.longitude,
//     this.priceType,
//     this.currency,
//     this.status,
//     this.level,
//     this.postType,
//     this.deadline,
//     this.skills,
//     this.commission,
//     this.isFeatured,
//     this.categoryId,
//     this.subCategoryId,
//     this.userId,
//     this.createdAt,
//     this.updatedAt,
//     this.images,
//     this.customer,
//   });
//
//   factory Service.fromJson(Map<String, dynamic> json) => Service(
//         id: json["id"],
//         title: json["title"],
//         slug: json["slug"],
//         description: json["description"],
//         price: json["price"]?.toDouble(),
//         location: json["location"],
//         latitude: json["latitude"],
//         longitude: json["longitude"],
//         priceType: json["priceType"],
//         currency: json["currency"],
//         status: json["status"],
//         level: json["level"],
//         postType: json["postType"],
//         deadline: json["deadline"],
//         skills: json["skills"],
//         commission: json["commission"],
//         isFeatured: json["is_featured"],
//         categoryId: json["category_id"],
//         subCategoryId: json["sub_category_id"],
//         userId: json["user_id"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         images: json["images"] == null
//             ? []
//             : List<ServiceImage>.from(
//                 json["images"]!.map((x) => ServiceImage.fromJson(x))),
//         customer: json["customer"] == null
//             ? null
//             : Customer.fromJson(json["customer"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "slug": slug,
//         "description": description,
//         "price": price,
//         "location": location,
//         "latitude": latitude,
//         "longitude": longitude,
//         "priceType": priceType,
//         "currency": currency,
//         "status": status,
//         "level": level,
//         "postType": postType,
//         "deadline": deadline,
//         "skills": skills,
//         "commission": commission,
//         "is_featured": isFeatured,
//         "category_id": categoryId,
//         "sub_category_id": subCategoryId,
//         "user_id": userId,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "images": images == null
//             ? []
//             : List<dynamic>.from(images!.map((x) => x.toJson())),
//         "customer": customer?.toJson(),
//       };
// }
//
// class ServiceImage {
//   final int? id;
//   final String? name;
//   final String? path;
//   final int? serviceId;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//
//   ServiceImage({
//     this.id,
//     this.name,
//     this.path,
//     this.serviceId,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory ServiceImage.fromJson(Map<String, dynamic> json) => ServiceImage(
//         id: json["id"],
//         name: json["name"],
//         path: json["path"],
//         serviceId: json["service_id"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "path": path,
//         "service_id": serviceId,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }
//
// class Customer {
//   final int? id;
//   final String? name;
//   final String? mobile;
//   final String? email;
//   final DateTime? emailVerifiedAt;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//
//   Customer({
//     this.id,
//     this.name,
//     this.mobile,
//     this.email,
//     this.emailVerifiedAt,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Customer.fromJson(Map<String, dynamic> json) => Customer(
//         id: json["id"],
//         name: json["name"],
//         mobile: json["mobile"],
//         email: json["email"],
//         emailVerifiedAt: json["email_verified_at"] == null
//             ? null
//             : DateTime.parse(json["email_verified_at"]),
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "mobile": mobile,
//         "email": email,
//         "email_verified_at": emailVerifiedAt?.toIso8601String(),
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }
class Providerservicemodel {
  final bool? success;
  final int? status;
  final String? message;
  final List<Service>? data;

  Providerservicemodel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory Providerservicemodel.fromJson(Map<String, dynamic> json) =>
      Providerservicemodel(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Service>.from(json["data"]!.map((x) => Service.fromJson(x))),
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

class Service {
  final int? id;
  final String? title;
  final String? slug;
  final String? description;
  final double? price;
  final String? location;
  final String? latitude;
  final String? longitude;
  final String? priceType;
  final String? currency;
  final String? status;
  final String? level;
  final String? postType;
  final String? deadline;
  final String? skills;
  final int? commission;
  final int? isFeatured;
  final int? categoryId;
  final int? subCategoryId;
  final int? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<ServiceImage>? images;
  final Category? category;
  final Customer? customer;

  Service({
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

  factory Service.fromJson(Map<String, dynamic> json) => Service(
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
        skills: json["skills"],
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
                json["images"]!.map((x) => ServiceImage.fromJson(x))),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
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
        "deadline": deadline,
        "skills": skills,
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
        "category": category?.toJson(),
        "customer": customer?.toJson(),
      };
}

class ServiceImage {
  final int? id;
  final String? name;
  final String? path;
  final int? serviceId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

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

class Category {
  final int? id;
  final String? name;
  final String? slug;
  final String? description;
  final String? image;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

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
        "slug": slug,
        "description": description,
        "image": image,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Customer {
  final int? id;
  final String? name;
  final String? mobile;
  final String? email;
  final String? emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Profile? profile;

  Customer({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.profile,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        profile:
            json["profile"] == null ? null : Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "profile": profile?.toJson(),
      };
}

class Profile {
  final int? id;
  final String? lastName;
  final String? country;
  final String? bio;
  final String? language;
  final String? image;
  final String? location;
  final String? latitude;
  final String? longitude;
  final int? userId;
  final int? categoryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Profile({
    this.id,
    this.lastName,
    this.country,
    this.bio,
    this.language,
    this.image,
    this.location,
    this.latitude,
    this.longitude,
    this.userId,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        lastName: json["last_name"],
        country: json["country"],
        bio: json["bio"],
        language: json["language"],
        image: json["image"],
        location: json["location"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        userId: json["user_id"],
        categoryId: json["category_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "last_name": lastName,
        "country": country,
        "bio": bio,
        "language": language,
        "image": image,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
        "user_id": userId,
        "category_id": categoryId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
