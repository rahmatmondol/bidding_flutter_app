import 'dart:convert';

class GetServiceDataModel {
  bool? success;
  int? status;
  String? message;
  List<ServiceModel>? data;

  GetServiceDataModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory GetServiceDataModel.fromJson(Map<String, dynamic> json) =>
      GetServiceDataModel(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ServiceModel>.from(
                json["data"].map((x) => ServiceModel.fromJson(x))),
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

class ServiceModel {
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
  dynamic deadline;
  String? skills;
  int? commission;
  int? is_featured;
  int? category_id;
  int? sub_category_id;
  int? user_id;
  String? created_at;
  String? updated_at;
  List<ServiceImage>? images;
  Customer? customer;

  ServiceModel({
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
    this.is_featured,
    this.category_id,
    this.sub_category_id,
    this.user_id,
    this.created_at,
    this.updated_at,
    this.images,
    this.customer,
  });

  // Add this method to get skills as a List
  List<String> getSkillsList() {
    if (skills == null || skills!.isEmpty) return [];
    try {
      // Remove any extra quotes if present
      final cleanedSkills = skills!.replaceAll('\\', '');
      final decodedSkills = jsonDecode(cleanedSkills);
      if (decodedSkills is List) {
        return decodedSkills.map((e) => e.toString()).toList();
      }
      return [];
    } catch (e) {
      print('Error decoding skills: $e');
      print('Original skills string: $skills');
      return [];
    }
  }

  // Add this method to get skills as a comma-separated string
  String getSkillsString() {
    final skillsList = getSkillsList();
    return skillsList.isEmpty ? 'No skills specified' : skillsList.join(', ');
  }

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
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
        is_featured: json["is_featured"],
        category_id: json["category_id"],
        sub_category_id: json["sub_category_id"],
        user_id: json["user_id"],
        created_at: json["created_at"],
        updated_at: json["updated_at"],
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
        "deadline": deadline,
        "skills": skills,
        "commission": commission,
        "is_featured": is_featured,
        "category_id": category_id,
        "sub_category_id": sub_category_id,
        "user_id": user_id,
        "created_at": created_at,
        "updated_at": updated_at,
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "customer": customer?.toJson(),
      };
}

class ServiceImage {
  int? id;
  String? name;
  String? path;
  int? service_id;
  String? created_at;
  String? updated_at;

  ServiceImage({
    this.id,
    this.name,
    this.path,
    this.service_id,
    this.created_at,
    this.updated_at,
  });

  factory ServiceImage.fromJson(Map<String, dynamic> json) => ServiceImage(
        id: json["id"],
        name: json["name"],
        path: json["path"],
        service_id: json["service_id"],
        created_at: json["created_at"],
        updated_at: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "path": path,
        "service_id": service_id,
        "created_at": created_at,
        "updated_at": updated_at,
      };
}

class Customer {
  int? id;
  String? name;
  String? mobile;
  String? email;
  String? email_verified_at;
  String? created_at;
  String? updated_at;

  Customer({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.email_verified_at,
    this.created_at,
    this.updated_at,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        email_verified_at: json["email_verified_at"],
        created_at: json["created_at"],
        updated_at: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "email": email,
        "email_verified_at": email_verified_at,
        "created_at": created_at,
        "updated_at": updated_at,
      };
}
