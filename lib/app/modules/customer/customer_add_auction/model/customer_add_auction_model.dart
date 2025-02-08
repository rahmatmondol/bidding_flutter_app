// To parse this JSON data, do
//
//     final CustomerAddAuctionModel = CustomerAddAuctionModelFromJson(jsonString);

import 'dart:convert';

CustomerAddAuctionModel customerAddAuctionModelFromJson(String str) =>
    CustomerAddAuctionModel.fromJson(json.decode(str));

String customerAddAuctionModelToJson(CustomerAddAuctionModel data) =>
    json.encode(data.toJson());

class CustomerAddAuctionModel {
  bool? success;
  int? status;
  String? message;
  Data? data;

  CustomerAddAuctionModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory CustomerAddAuctionModel.fromJson(Map<String, dynamic> json) =>
      CustomerAddAuctionModel(
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
  Service? service;

  Data({
    this.service,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        service:
            json["service"] == null ? null : Service.fromJson(json["service"]),
      );

  Map<String, dynamic> toJson() => {
        "service": service?.toJson(),
      };
}

class Service {
  String? name;
  String? categoryId;
  int? customerId;
  List<Zone>? zone;
  String? price;
  String? priceType;
  String? level;
  String? currency;
  String? commotion;
  String? providerAmount;
  String? status;
  String? skill;
  String? description;
  String? address;
  String? location;
  int? id;
  List<Image>? image;

  Service({
    this.name,
    this.categoryId,
    this.customerId,
    this.zone,
    this.price,
    this.priceType,
    this.level,
    this.currency,
    this.commotion,
    this.providerAmount,
    this.status,
    this.skill,
    this.description,
    this.address,
    this.location,
    this.id,
    this.image,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        name: json["name"],
        categoryId: json["category_id"],
        customerId: json["customer_id"],
        zone: json["zone"] == null
            ? []
            : List<Zone>.from(json["zone"]!.map((x) => Zone.fromJson(x))),
        price: json["price"],
        priceType: json["price_type"],
        level: json["level"],
        currency: json["currency"],
        commotion: json["commotion"],
        providerAmount: json["provider_amount"],
        status: json["status"],
        skill: json["skill"],
        description: json["description"],
        address: json["address"],
        location: json["location"],
        id: json["id"],
        image: json["image"] == null
            ? []
            : List<Image>.from(json["image"]!.map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "category_id": categoryId,
        "customer_id": customerId,
        "zone": zone == null
            ? []
            : List<dynamic>.from(zone!.map((x) => x.toJson())),
        "price": price,
        "price_type": priceType,
        "level": level,
        "currency": currency,
        "commotion": commotion,
        "provider_amount": providerAmount,
        "status": status,
        "skill": skill,
        "description": description,
        "address": address,
        "location": location,
        "id": id,
        "image": image == null
            ? []
            : List<dynamic>.from(image!.map((x) => x.toJson())),
      };
}

class Image {
  int? serviceId;
  String? path;
  int? id;

  Image({
    this.serviceId,
    this.path,
    this.id,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        serviceId: json["service_id"],
        path: json["path"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "service_id": serviceId,
        "path": path,
        "id": id,
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
