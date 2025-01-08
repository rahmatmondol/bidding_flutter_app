class CustomerInfoModel {
  final int? id;
  final String? name;
  final String? mobile;
  final String? email;
  final String? emailVerifiedAt;
  final String? createdAt;
  final String? updatedAt;
  final ProfileModel? profile;

  CustomerInfoModel({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.profile,
  });

  factory CustomerInfoModel.fromJson(Map<String, dynamic> json) =>
      CustomerInfoModel(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        profile: json["profile"] != null
            ? ProfileModel.fromJson(json["profile"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "profile": profile?.toJson(),
      };
}

class ProfileModel {
  final int? id;
  final String? lastName;
  final String? country;
  final String? bio;
  final String? language;
  late final String? image;
  final String? location;
  final String? latitude;
  final String? longitude;
  final int? userId;
  final int? categoryId;
  final String? createdAt;
  final String? updatedAt;

  ProfileModel({
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

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
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
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
