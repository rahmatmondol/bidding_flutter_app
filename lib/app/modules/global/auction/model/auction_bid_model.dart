import 'auction_booking_model.dart';

class AuctionBidModel {
  final int id;
  final int amount;
  final String message;
  final String type;
  final String status;
  final int serviceId;
  final int providerId;
  final int customerId;
  final String createdAt;
  final String updatedAt;
  final ProviderModel provider;
  final AuctionModel service;
  final CustomerModel customer;

  AuctionBidModel({
    required this.id,
    required this.amount,
    required this.message,
    required this.type,
    required this.status,
    required this.serviceId,
    required this.providerId,
    required this.customerId,
    required this.createdAt,
    required this.updatedAt,
    required this.provider,
    required this.service,
    required this.customer,
  });

  factory AuctionBidModel.fromJson(Map<String, dynamic> json) {
    return AuctionBidModel(
      id: json['id'] ?? 0,
      amount: json['amount'] ?? 0,
      message: json['message'] ?? '',
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      serviceId: json['service_id'] ?? 0,
      providerId: json['provider_id'] ?? 0,
      customerId: json['customer_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      provider: ProviderModel.fromJson(json['provider'] ?? {}),
      service: AuctionModel.fromJson(json['service'] ?? {}),
      customer: CustomerModel.fromJson(json['customer'] ?? {}),
    );
  }
}

class ProviderModel {
  final int id;
  final String name;
  final String mobile;
  final String email;
  final String emailVerifiedAt;
  final String createdAt;
  final String updatedAt;
  final ProfileModel? profile;

  ProviderModel({
    required this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    this.profile,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      mobile: json['mobile'] ?? '',
      email: json['email'] ?? '',
      emailVerifiedAt: json['email_verified_at'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      profile: json['profile'] != null
          ? ProfileModel.fromJson(json['profile'])
          : null,
    );
  }
}

class CustomerModel {
  final int id;
  final String name;
  final String mobile;
  final String email;
  final String emailVerifiedAt;
  final String createdAt;
  final String updatedAt;
  final ProfileModel? profile;

  CustomerModel({
    required this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    this.profile,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      mobile: json['mobile'] ?? '',
      email: json['email'] ?? '',
      emailVerifiedAt: json['email_verified_at'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      profile: json['profile'] != null
          ? ProfileModel.fromJson(json['profile'])
          : null,
    );
  }
}

class ProfileModel {
  final int id;
  final String lastName;
  final String country;
  final String bio;
  final String language;
  final String image;
  final String location;
  final String latitude;
  final String longitude;
  final int userId;
  final int categoryId;
  final String createdAt;
  final String updatedAt;

  ProfileModel({
    required this.id,
    required this.lastName,
    required this.country,
    required this.bio,
    required this.language,
    required this.image,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.userId,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? 0,
      lastName: json['last_name'] ?? '',
      country: json['country'] ?? '',
      bio: json['bio'] ?? '',
      language: json['language'] ?? '',
      image: json['image'] ?? '',
      location: json['location'] ?? '',
      latitude: json['latitude']?.toString() ?? '',
      longitude: json['longitude']?.toString() ?? '',
      userId: json['user_id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
