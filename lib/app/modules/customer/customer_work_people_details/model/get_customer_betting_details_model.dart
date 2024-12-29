// To parse this JSON data, do
//
//     final getBettingListDetailsModel = getBettingListDetailsModelFromJson(jsonString);

import 'dart:convert';

GetBettingListDetailsModel getBettingListDetailsModelFromJson(String str) => GetBettingListDetailsModel.fromJson(json.decode(str));

String getBettingListDetailsModelToJson(GetBettingListDetailsModel data) => json.encode(data.toJson());

class GetBettingListDetailsModel {
    bool? success;
    int? status;
    String? message;
    Data? data;

    GetBettingListDetailsModel({
        this.success,
        this.status,
        this.message,
        this.data,
    });

    factory GetBettingListDetailsModel.fromJson(Map<String, dynamic> json) => GetBettingListDetailsModel(
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
    Provider? provider;

    Data({
        this.provider,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        provider: json["provider"] == null ? null : Provider.fromJson(json["provider"]),
    );

    Map<String, dynamic> toJson() => {
        "provider": provider?.toJson(),
    };
}

class Provider {
    int? id;
    int? zoneId;
    String? name;
    String? email;
    String? phone;
    String? country;
    int? oneStar;
    int? twoStar;
    int? threeStar;
    int? fourStar;
    int? fiveStar;
    int? totalServiceCount;
    int? avgRating;
    String? image;
    dynamic bio;
    Betting? betting;
    List<dynamic>? reviews;

    Provider({
        this.id,
        this.zoneId,
        this.name,
        this.email,
        this.phone,
        this.country,
        this.oneStar,
        this.twoStar,
        this.threeStar,
        this.fourStar,
        this.fiveStar,
        this.totalServiceCount,
        this.avgRating,
        this.image,
        this.bio,
        this.betting,
        this.reviews,
    });

    factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        id: json["id"],
        zoneId: json["zone_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        country: json["country"],
        oneStar: json["one_star"],
        twoStar: json["two_star"],
        threeStar: json["three_star"],
        fourStar: json["four_star"],
        fiveStar: json["five_star"],
        totalServiceCount: json["Total_service_count"],
        avgRating: json["avg_rating"],
        image: json["image"],
        bio: json["bio"],
        betting: json["betting"] == null ? null : Betting.fromJson(json["betting"]),
        reviews: json["reviews"] == null ? [] : List<dynamic>.from(json["reviews"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "zone_id": zoneId,
        "name": name,
        "email": email,
        "phone": phone,
        "country": country,
        "one_star": oneStar,
        "two_star": twoStar,
        "three_star": threeStar,
        "four_star": fourStar,
        "five_star": fiveStar,
        "Total_service_count": totalServiceCount,
        "avg_rating": avgRating,
        "image": image,
        "bio": bio,
        "betting": betting?.toJson(),
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
    };
}

class Betting {
    int? id;
    int? providerId;
    int? serviceId;
    String? additionalDetails;
    Metadata? metadata;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    Betting({
        this.id,
        this.providerId,
        this.serviceId,
        this.additionalDetails,
        this.metadata,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory Betting.fromJson(Map<String, dynamic> json) => Betting(
        id: json["id"],
        providerId: json["provider_id"],
        serviceId: json["service_id"],
        additionalDetails: json["additional_details"],
        metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "provider_id": providerId,
        "service_id": serviceId,
        "additional_details": additionalDetails,
        "metadata": metadata?.toJson(),
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class Metadata {
    int? id;
    String? name;
    int? parentId;
    int? categoryId;
    int? customerId;
    List<Zone>? zone;
    String? price;
    String? priceType;
    String? level;
    String? currency;
    String? skill;
    int? commotion;
    int? providerAmount;
    String? address;
    String? status;
    String? description;
    String? location;
    DateTime? createdAt;

    Metadata({
        this.id,
        this.name,
        this.parentId,
        this.categoryId,
        this.customerId,
        this.zone,
        this.price,
        this.priceType,
        this.level,
        this.currency,
        this.skill,
        this.commotion,
        this.providerAmount,
        this.address,
        this.status,
        this.description,
        this.location,
        this.createdAt,
    });

    factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        id: json["id"],
        name: json["name"],
        parentId: json["parent_id"],
        categoryId: json["category_id"],
        customerId: json["customer_id"],
        zone: json["zone"] == null ? [] : List<Zone>.from(json["zone"]!.map((x) => Zone.fromJson(x))),
        price: json["price"],
        priceType: json["price_type"],
        level: json["level"],
        currency: json["currency"],
        skill: json["skill"],
        commotion: json["commotion"],
        providerAmount: json["provider_amount"],
        address: json["address"],
        status: json["status"],
        description: json["description"],
        location: json["location"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "parent_id": parentId,
        "category_id": categoryId,
        "customer_id": customerId,
        "zone": zone == null ? [] : List<dynamic>.from(zone!.map((x) => x.toJson())),
        "price": price,
        "price_type": priceType,
        "level": level,
        "currency": currency,
        "skill": skill,
        "commotion": commotion,
        "provider_amount": providerAmount,
        "address": address,
        "status": status,
        "description": description,
        "location": location,
        "created_at": createdAt?.toIso8601String(),
    };
}

class Zone {
    int? id;
    String? name;

    Zone({
        this.id,
        this.name,
    });

    factory Zone.fromJson(Map<String, dynamic> json) => Zone(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
