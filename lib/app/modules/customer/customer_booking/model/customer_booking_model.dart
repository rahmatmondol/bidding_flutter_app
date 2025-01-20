class BookingModel {
  final int id;
  final String status;
  final int serviceId;
  final int providerId;
  final int customerId;
  final int bidId;
  final String createdAt;
  final String updatedAt;
  final ServiceModel service;
  final BidModel bid;

  BookingModel({
    required this.id,
    required this.status,
    required this.serviceId,
    required this.providerId,
    required this.customerId,
    required this.bidId,
    required this.createdAt,
    required this.updatedAt,
    required this.service,
    required this.bid,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] ?? 0,
      status: json['status'] ?? '',
      serviceId: json['service_id'] ?? 0,
      providerId: json['provider_id'] ?? 0,
      customerId: json['customer_id'] ?? 0,
      bidId: json['bid_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      service: ServiceModel.fromJson(json['service'] ?? {}),
      bid: BidModel.fromJson(json['bid'] ?? {}),
    );
  }
}

class ServiceModel {
  final int id;
  final String title;
  final String description;
  final dynamic price;
  final String location;
  final String priceType;
  final String currency;
  final String level;
  final List<ServiceImageModel> images;

  ServiceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.location,
    required this.priceType,
    required this.currency,
    required this.level,
    required this.images,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      location: json['location'] ?? '',
      priceType: json['priceType'] ?? '',
      currency: json['currency'] ?? '',
      level: json['level'] ?? '',
      images: List<ServiceImageModel>.from(
        (json['images'] ?? []).map((x) => ServiceImageModel.fromJson(x)),
      ),
    );
  }
}

class ServiceImageModel {
  final int id;
  final String name;
  final String path;

  ServiceImageModel({
    required this.id,
    required this.name,
    required this.path,
  });

  factory ServiceImageModel.fromJson(Map<String, dynamic> json) {
    return ServiceImageModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      path: json['path'] ?? '',
    );
  }
}

class BidModel {
  final int id;
  final dynamic amount;

  BidModel({
    required this.id,
    required this.amount,
  });

  factory BidModel.fromJson(Map<String, dynamic> json) {
    return BidModel(
      id: json['id'] ?? 0,
      amount: json['amount'] ?? 0,
    );
  }
}
