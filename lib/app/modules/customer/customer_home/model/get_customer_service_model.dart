// To parse this JSON data, do
//
//     final getCustomerServiceModel = getCustomerServiceModelFromJson(jsonString);

import 'dart:convert';

GetCustomerServiceModel getCustomerServiceModelFromJson(String str) => GetCustomerServiceModel.fromJson(json.decode(str));

String getCustomerServiceModelToJson(GetCustomerServiceModel data) => json.encode(data.toJson());

class GetCustomerServiceModel {
    bool? success;
    int? status;
    String? message;
    Data? data;

    GetCustomerServiceModel({
        this.success,
        this.status,
        this.message,
        this.data,
    });

    factory GetCustomerServiceModel.fromJson(Map<String, dynamic> json) => GetCustomerServiceModel(
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
    List<Datum>? data;

    Data({
        this.data,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
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
    List<String>? skill;
    int? commotion;
    int? providerAmount;
    String? address;
    String? status;
    String? description;
    String? location;
    List<Image>? images;

    Datum({
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
        this.images,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        skill: json["skill"] == null ? [] : List<String>.from(json["skill"]!.map((x) => x)),
        commotion: json["commotion"],
        providerAmount: json["provider_amount"],
        address: json["address"],
        status: json["status"],
        description: json["description"],
        location: json["location"],
        images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
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
        "skill": skill == null ? [] : List<dynamic>.from(skill!.map((x) => x)),
        "commotion": commotion,
        "provider_amount": providerAmount,
        "address": address,
        "status": status,
        "description": description,
        "location": location,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
    };
}

class Image {
    int? id;
    int? serviceId;
    String? path;

    Image({
        this.id,
        this.serviceId,
        this.path,
    });

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        serviceId: json["service_id"],
        path: json["path"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "path": path,
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
