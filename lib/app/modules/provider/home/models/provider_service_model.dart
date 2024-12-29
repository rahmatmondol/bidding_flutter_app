// To parse this JSON data, do
//
//     final providerservicemodel = providerservicemodelFromJson(jsonString);

import 'dart:convert';

Providerservicemodel providerservicemodelFromJson(String str) => Providerservicemodel.fromJson(json.decode(str));

String providerservicemodelToJson(Providerservicemodel data) => json.encode(data.toJson());

class Providerservicemodel {
  bool? success;
  int? status;
  String? message;
  Data? data;

  Providerservicemodel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory Providerservicemodel.fromJson(Map<String, dynamic> json) => Providerservicemodel(
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
  List<ServiceProvider>? service;

  Data({
    this.service,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    service: json["service"] == null ? [] : List<ServiceProvider>.from(json["service"]!.map((x) => ServiceProvider.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "service": service == null ? [] : List<dynamic>.from(service!.map((x) => x.toJson())),
  };
}

class ServiceProvider {
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
  List<Images>? images;

  ServiceProvider({
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
    this.images,
  });

  factory ServiceProvider.fromJson(Map<String, dynamic> json) => ServiceProvider(
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
    images: json["images"] == null ? [] : List<Images>.from(json["images"]!.map((x) => Images.fromJson(x))),
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

class Images {
  int? id;
  int? serviceId;
  String? path;

  Images({
    this.id,
    this.serviceId,
    this.path,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
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
