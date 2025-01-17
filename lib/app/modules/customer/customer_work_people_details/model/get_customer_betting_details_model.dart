// // To parse this JSON data, do
// //
// //     final getBettingListDetailsModel = getBettingListDetailsModelFromJson(jsonString);
//
// import 'dart:convert';
//
// GetBettingListDetailsModel getBettingListDetailsModelFromJson(String str) => GetBettingListDetailsModel.fromJson(json.decode(str));
//
// String getBettingListDetailsModelToJson(GetBettingListDetailsModel data) => json.encode(data.toJson());
//
// class GetBettingListDetailsModel {
//     bool? success;
//     int? status;
//     String? message;
//     Data? data;
//
//     GetBettingListDetailsModel({
//         this.success,
//         this.status,
//         this.message,
//         this.data,
//     });
//
//     factory GetBettingListDetailsModel.fromJson(Map<String, dynamic> json) => GetBettingListDetailsModel(
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
//     Provider? provider;
//
//     Data({
//         this.provider,
//     });
//
//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         provider: json["provider"] == null ? null : Provider.fromJson(json["provider"]),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "provider": provider?.toJson(),
//     };
// }
//
// class Provider {
//     int? id;
//     int? zoneId;
//     String? name;
//     String? email;
//     String? phone;
//     String? country;
//     int? oneStar;
//     int? twoStar;
//     int? threeStar;
//     int? fourStar;
//     int? fiveStar;
//     int? totalServiceCount;
//     int? avgRating;
//     String? image;
//     dynamic bio;
//     Betting? betting;
//     List<dynamic>? reviews;
//
//     Provider({
//         this.id,
//         this.zoneId,
//         this.name,
//         this.email,
//         this.phone,
//         this.country,
//         this.oneStar,
//         this.twoStar,
//         this.threeStar,
//         this.fourStar,
//         this.fiveStar,
//         this.totalServiceCount,
//         this.avgRating,
//         this.image,
//         this.bio,
//         this.betting,
//         this.reviews,
//     });
//
//     factory Provider.fromJson(Map<String, dynamic> json) => Provider(
//         id: json["id"],
//         zoneId: json["zone_id"],
//         name: json["name"],
//         email: json["email"],
//         phone: json["phone"],
//         country: json["country"],
//         oneStar: json["one_star"],
//         twoStar: json["two_star"],
//         threeStar: json["three_star"],
//         fourStar: json["four_star"],
//         fiveStar: json["five_star"],
//         totalServiceCount: json["Total_service_count"],
//         avgRating: json["avg_rating"],
//         image: json["image"],
//         bio: json["bio"],
//         betting: json["betting"] == null ? null : Betting.fromJson(json["betting"]),
//         reviews: json["reviews"] == null ? [] : List<dynamic>.from(json["reviews"]!.map((x) => x)),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "zone_id": zoneId,
//         "name": name,
//         "email": email,
//         "phone": phone,
//         "country": country,
//         "one_star": oneStar,
//         "two_star": twoStar,
//         "three_star": threeStar,
//         "four_star": fourStar,
//         "five_star": fiveStar,
//         "Total_service_count": totalServiceCount,
//         "avg_rating": avgRating,
//         "image": image,
//         "bio": bio,
//         "betting": betting?.toJson(),
//         "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
//     };
// }
//
// class Betting {
//     int? id;
//     int? providerId;
//     int? serviceId;
//     String? additionalDetails;
//     Metadata? metadata;
//     String? status;
//     DateTime? createdAt;
//     DateTime? updatedAt;
//
//     Betting({
//         this.id,
//         this.providerId,
//         this.serviceId,
//         this.additionalDetails,
//         this.metadata,
//         this.status,
//         this.createdAt,
//         this.updatedAt,
//     });
//
//     factory Betting.fromJson(Map<String, dynamic> json) => Betting(
//         id: json["id"],
//         providerId: json["provider_id"],
//         serviceId: json["service_id"],
//         additionalDetails: json["additional_details"],
//         metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
//         status: json["status"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "provider_id": providerId,
//         "service_id": serviceId,
//         "additional_details": additionalDetails,
//         "metadata": metadata?.toJson(),
//         "status": status,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//     };
// }
//
// class Metadata {
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
//     String? skill;
//     int? commotion;
//     int? providerAmount;
//     String? address;
//     String? status;
//     String? description;
//     String? location;
//     DateTime? createdAt;
//
//     Metadata({
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
//         this.createdAt,
//     });
//
//     factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
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
//         skill: json["skill"],
//         commotion: json["commotion"],
//         providerAmount: json["provider_amount"],
//         address: json["address"],
//         status: json["status"],
//         description: json["description"],
//         location: json["location"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
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
//         "skill": skill,
//         "commotion": commotion,
//         "provider_amount": providerAmount,
//         "address": address,
//         "status": status,
//         "description": description,
//         "location": location,
//         "created_at": createdAt?.toIso8601String(),
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

import 'dart:convert';

GetBettingListDetailsModel getBettingListDetailsModelFromJson(String str) =>
    GetBettingListDetailsModel.fromJson(json.decode(str));

String getBettingListDetailsModelToJson(GetBettingListDetailsModel data) =>
    json.encode(data.toJson());

class GetBettingListDetailsModel {
  String? message;
  int? status;
  bool? success;
  BidData? data;

  GetBettingListDetailsModel({
    this.message,
    this.status,
    this.success,
    this.data,
  });

  factory GetBettingListDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetBettingListDetailsModel(
        message: json["message"],
        status: json["status"],
        success: json["success"],
        data: json["data"] == null ? null : BidData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "success": success,
        "data": data?.toJson(),
      };
}

class BidData {
  int? id;
  double? amount;
  String? message;
  String? type;
  String? status;
  int? serviceId;
  int? providerId;
  int? customerId;
  DateTime? createdAt;
  DateTime? updatedAt;
  BidProvider? provider;
  Service? service;

  BidData({
    this.id,
    this.amount,
    this.message,
    this.type,
    this.status,
    this.serviceId,
    this.providerId,
    this.customerId,
    this.createdAt,
    this.updatedAt,
    this.provider,
    this.service,
  });

  factory BidData.fromJson(Map<String, dynamic> json) => BidData(
        id: json["id"],
        amount: json["amount"]?.toDouble(),
        message: json["message"],
        type: json["type"],
        status: json["status"],
        serviceId: json["service_id"],
        providerId: json["provider_id"],
        customerId: json["customer_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        provider: json["provider"] == null
            ? null
            : BidProvider.fromJson(json["provider"]),
        service:
            json["service"] == null ? null : Service.fromJson(json["service"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "message": message,
        "type": type,
        "status": status,
        "service_id": serviceId,
        "provider_id": providerId,
        "customer_id": customerId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "provider": provider?.toJson(),
        "service": service?.toJson(),
      };
}

class BidProvider {
  int? id;
  String? name;
  String? mobile;
  String? email;
  DateTime? emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  ProviderProfile? profile;
  List<dynamic>? reviews;

  BidProvider({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.profile,
    this.reviews,
  });

  factory BidProvider.fromJson(Map<String, dynamic> json) => BidProvider(
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
        profile: json["profile"] == null
            ? null
            : ProviderProfile.fromJson(json["profile"]),
        reviews: json["reviews"] == null
            ? []
            : List<dynamic>.from(json["reviews"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "email": email,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "profile": profile?.toJson(),
        "reviews":
            reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
      };
}

class ProviderProfile {
  int? id;
  String? lastName;
  String? country;
  String? bio;
  String? language;
  String? image;
  String? location;
  String? latitude;
  String? longitude;
  int? userId;
  int? categoryId;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProviderProfile({
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

  factory ProviderProfile.fromJson(Map<String, dynamic> json) =>
      ProviderProfile(
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

class Service {
  int? id;
  String? title;
  String? slug;
  String? description;
  int? price;
  String? location;
  String? latitude;
  String? longitude;
  String? priceType;
  String? currency;
  String? status;
  String? level;
  String? postType;
  dynamic deadline;
  String? skills;
  int? commission;
  int? isFeatured;
  int? categoryId;
  int? subCategoryId;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

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
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
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
      };
}
