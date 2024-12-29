// To parse this JSON data, do
//
//     final customerServiceDetailsModel = customerServiceDetailsModelFromJson(jsonString);

import 'dart:convert';

CustomerServiceDetailsModel customerServiceDetailsModelFromJson(String str) => CustomerServiceDetailsModel.fromJson(json.decode(str));

String customerServiceDetailsModelToJson(CustomerServiceDetailsModel data) => json.encode(data.toJson());

class CustomerServiceDetailsModel {
    bool? success;
    int? status;
    String? message;
    CustomerServiceDetailsModelData? data;

    CustomerServiceDetailsModel({
        this.success,
        this.status,
        this.message,
        this.data,
    });

    factory CustomerServiceDetailsModel.fromJson(Map<String, dynamic> json) => CustomerServiceDetailsModel(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : CustomerServiceDetailsModelData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class CustomerServiceDetailsModelData {
    DataData? data;

    CustomerServiceDetailsModelData({
        this.data,
    });

    factory CustomerServiceDetailsModelData.fromJson(Map<String, dynamic> json) => CustomerServiceDetailsModelData(
        data: json["data"] == null ? null : DataData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class DataData {
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
    Customer? customer;
    List<dynamic>? bettings;
    List<Image>? images;

    DataData({
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
        this.customer,
        this.bettings,
        this.images,
    });

    factory DataData.fromJson(Map<String, dynamic> json) => DataData(
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
        customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
        bettings: json["bettings"] == null ? [] : List<dynamic>.from(json["bettings"]!.map((x) => x)),
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
        "customer": customer?.toJson(),
        "bettings": bettings == null ? [] : List<dynamic>.from(bettings!.map((x) => x)),
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
    };
}

class Customer {
    int? id;
    String? name;
    String? email;
    String? phone;
    int? emailVerify;
    String? image;
    String? status;

    Customer({
        this.id,
        this.name,
        this.email,
        this.phone,
        this.emailVerify,
        this.image,
        this.status,
    });

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        emailVerify: json["email_verify"],
        image: json["image"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "email_verify": emailVerify,
        "image": image,
        "status": status,
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
