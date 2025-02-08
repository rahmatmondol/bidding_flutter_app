/*
// class AuctionBookingModel {
//   final int id;
//   final String status;
//   final int serviceId;
//   final int providerId;
//   final int customerId;
//   final int bidId;
//   final String createdAt;
//   final String updatedAt;
//   final ServiceModel service;
//   final BidModel bid;
//
//   AuctionBookingModel({
//     required this.id,
//     required this.status,
//     required this.serviceId,
//     required this.providerId,
//     required this.customerId,
//     required this.bidId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.service,
//     required this.bid,
//   });
//
//   factory AuctionBookingModel.fromJson(Map<String, dynamic> json) {
//     return AuctionBookingModel(
//       id: json['id'] ?? 0,
//       status: json['status'] ?? '',
//       serviceId: json['service_id'] ?? 0,
//       providerId: json['provider_id'] ?? 0,
//       customerId: json['customer_id'] ?? 0,
//       bidId: json['bid_id'] ?? 0,
//       createdAt: json['created_at'] ?? '',
//       updatedAt: json['updated_at'] ?? '',
//       service: ServiceModel.fromJson(json['service'] ?? {}),
//       bid: BidModel.fromJson(json['bid'] ?? {}),
//     );
//   }
// }
//
// class ServiceModel {
//   final int id;
//   final String title;
//   final String description;
//   final dynamic price;
//   final String location;
//   final String priceType;
//   final String currency;
//   final String level;
//   final List<ServiceImageModel> images;
//
//   ServiceModel({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.price,
//     required this.location,
//     required this.priceType,
//     required this.currency,
//     required this.level,
//     required this.images,
//   });
//
//   factory ServiceModel.fromJson(Map<String, dynamic> json) {
//     return ServiceModel(
//       id: json['id'] ?? 0,
//       title: json['title'] ?? '',
//       description: json['description'] ?? '',
//       price: json['price'] ?? 0,
//       location: json['location'] ?? '',
//       priceType: json['priceType'] ?? '',
//       currency: json['currency'] ?? '',
//       level: json['level'] ?? '',
//       images: List<ServiceImageModel>.from(
//         (json['images'] ?? []).map((x) => ServiceImageModel.fromJson(x)),
//       ),
//     );
//   }
// }
//
// class ServiceImageModel {
//   final int id;
//   final String name;
//   final String path;
//
//   ServiceImageModel({
//     required this.id,
//     required this.name,
//     required this.path,
//   });
//
//   factory ServiceImageModel.fromJson(Map<String, dynamic> json) {
//     return ServiceImageModel(
//       id: json['id'] ?? 0,
//       name: json['name'] ?? '',
//       path: json['path'] ?? '',
//     );
//   }
// }
//
// class BidModel {
//   final int id;
//   final dynamic amount;
//
//   BidModel({
//     required this.id,
//     required this.amount,
//   });
//
//   factory BidModel.fromJson(Map<String, dynamic> json) {
//     return BidModel(
//       id: json['id'] ?? 0,
//       amount: json['amount'] ?? 0,
//     );
//   }
// }
class AuctionModel {
  final int id;
  final String title;
  final String slug;
  final String description;
  final dynamic price;
  final String location;
  final String latitude;
  final String longitude;
  final String priceType;
  final String currency;
  final String status;
  final String level;
  final String postType;
  final String? deadline;
  final String? skills;
  final int commission;
  final int isFeatured;
  final int categoryId;
  final int subCategoryId;
  final int userId;
  final String createdAt;
  final String updatedAt;
  final List<AuctionImageModel> images;

  AuctionModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.price,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.priceType,
    required this.currency,
    required this.status,
    required this.level,
    required this.postType,
    this.deadline,
    this.skills,
    required this.commission,
    required this.isFeatured,
    required this.categoryId,
    required this.subCategoryId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
  });

  factory AuctionModel.fromJson(Map<String, dynamic> json) {
    return AuctionModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      location: json['location'] ?? '',
      latitude: json['latitude']?.toString() ?? '',
      longitude: json['longitude']?.toString() ?? '',
      priceType: json['priceType'] ?? '',
      currency: json['currency'] ?? '',
      status: json['status'] ?? '',
      level: json['level'] ?? '',
      postType: json['postType'] ?? '',
      deadline: json['deadline'],
      skills: json['skills'],
      commission: json['commission'] ?? 0,
      isFeatured: json['is_featured'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      subCategoryId: json['sub_category_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      images: List<AuctionImageModel>.from(
        (json['images'] ?? []).map((x) => AuctionImageModel.fromJson(x)),
      ),
    );
  }
}

class AuctionImageModel {
  final int id;
  final String name;
  final String path;
  final int serviceId;
  final String createdAt;
  final String updatedAt;

  AuctionImageModel({
    required this.id,
    required this.name,
    required this.path,
    required this.serviceId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AuctionImageModel.fromJson(Map<String, dynamic> json) {
    return AuctionImageModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      path: json['path'] ?? '',
      serviceId: json['service_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}*/
class AuctionModel {
  final int id;
  final String title;
  final String slug;
  final String description;
  final dynamic price;
  final String location;
  final String latitude;
  final String longitude;
  final String priceType;
  final String currency;
  final String status;
  final String level;
  final String postType;
  final String? deadline;
  final String? skills;
  final int commission;
  final int isFeatured;
  final int categoryId;
  final int subCategoryId;
  final int userId;
  final String createdAt;
  final String updatedAt;
  final List<AuctionImageModel> images;

  AuctionModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.price,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.priceType,
    required this.currency,
    required this.status,
    required this.level,
    required this.postType,
    this.deadline,
    this.skills,
    required this.commission,
    required this.isFeatured,
    required this.categoryId,
    required this.subCategoryId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
  });

  factory AuctionModel.fromJson(Map<String, dynamic> json) {
    return AuctionModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      location: json['location'] ?? '',
      latitude: json['latitude']?.toString() ?? '',
      longitude: json['longitude']?.toString() ?? '',
      priceType: json['priceType'] ?? '',
      currency: json['currency'] ?? '',
      status: json['status'] ?? '',
      level: json['level'] ?? '',
      postType: json['postType'] ?? '',
      deadline: json['deadline'],
      skills: json['skills'],
      commission: json['commission'] ?? 0,
      isFeatured: json['is_featured'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      subCategoryId: json['sub_category_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      images: List<AuctionImageModel>.from(
        (json['images'] ?? []).map((x) => AuctionImageModel.fromJson(x)),
      ),
    );
  }
}

class AuctionImageModel {
  final int id;
  final String name;
  final String path;
  final int serviceId;
  final String createdAt;
  final String updatedAt;

  AuctionImageModel({
    required this.id,
    required this.name,
    required this.path,
    required this.serviceId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AuctionImageModel.fromJson(Map<String, dynamic> json) {
    return AuctionImageModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      path: json['path'] ?? '',
      serviceId: json['service_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
