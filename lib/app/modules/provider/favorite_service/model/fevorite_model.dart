import 'dart:convert';

class FavoriteModel {
  String? message;
  int? status;
  bool? success;
  List<WishlistItem>? data;

  FavoriteModel({
    this.message,
    this.status,
    this.success,
    this.data,
  });

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <WishlistItem>[];
      json['data'].forEach((v) {
        data!.add(WishlistItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WishlistItem {
  int? id;
  int? providerId;
  int? serviceId;
  String? createdAt;
  String? updatedAt;
  Service? service;

  WishlistItem({
    this.id,
    this.providerId,
    this.serviceId,
    this.createdAt,
    this.updatedAt,
    this.service,
  });

  WishlistItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    serviceId = json['service_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    service =
        json['service'] != null ? Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['provider_id'] = providerId;
    data['service_id'] = serviceId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (service != null) {
      data['service'] = service!.toJson();
    }
    return data;
  }
}

class Service {
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
  Customer? customer;
  List<ServiceImage>? images;

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
    this.customer,
    this.images,
  });

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    price = json['price'] is int
        ? (json['price'] as int).toDouble()
        : json['price'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    priceType = json['priceType'];
    currency = json['currency'];
    status = json['status'];
    level = json['level'];
    postType = json['postType'];
    deadline = json['deadline'];

    // Handle skills parsing
    try {
      if (json['skills'] != null) {
        if (json['skills'] is String) {
          // Parse the string representation of the list
          final List<dynamic> parsedSkills = jsonDecode(json['skills']);
          skills = parsedSkills.map((e) => e.toString()).toList();
        } else if (json['skills'] is List) {
          skills = (json['skills'] as List).map((e) => e.toString()).toList();
        }
      }
    } catch (e) {
      print('Error parsing skills: $e');
      skills = [];
    }

    commission = json['commission'];
    isFeatured = json['is_featured'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    if (json['images'] != null) {
      images = <ServiceImage>[];
      json['images'].forEach((v) {
        images!.add(ServiceImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['description'] = description;
    data['price'] = price;
    data['location'] = location;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['priceType'] = priceType;
    data['currency'] = currency;
    data['status'] = status;
    data['level'] = level;
    data['postType'] = postType;
    data['deadline'] = deadline;
    data['skills'] = skills;
    data['commission'] = commission;
    data['is_featured'] = isFeatured;
    data['category_id'] = categoryId;
    data['sub_category_id'] = subCategoryId;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
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

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
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

  ServiceImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    path = json['path'];
    serviceId = json['service_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['path'] = path;
    data['service_id'] = serviceId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
