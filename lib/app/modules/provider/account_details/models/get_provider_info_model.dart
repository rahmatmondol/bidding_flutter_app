// To parse this JSON data, do
//
//     final getProviderInfoModel = getProviderInfoModelFromJson(jsonString);

import 'dart:convert';

GetProviderInfoModel getProviderInfoModelFromJson(String str) =>
    GetProviderInfoModel.fromJson(json.decode(str));

String getProviderInfoModelToJson(GetProviderInfoModel data) =>
    json.encode(data.toJson());

class GetProviderInfoModel {
  bool? success;
  int? status;
  String? message;
  Data? data;

  GetProviderInfoModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory GetProviderInfoModel.fromJson(Map<String, dynamic> json) =>
      GetProviderInfoModel(
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
        provider: json["provider"] == null
            ? null
            : Provider.fromJson(json["provider"]),
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
      };
}
