class ProviderBookingModel {
  final int id;
  final String status;
  final int serviceId;
  final int providerId;
  final int customerId;
  final int bidId;
  final String createdAt;
  final String updatedAt;
  final ProviderServiceModel service;
  final ProviderBidModel bid;

  ProviderBookingModel({
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

  factory ProviderBookingModel.fromJson(Map<String, dynamic> json) {
    return ProviderBookingModel(
      id: json['id'] ?? 0,
      status: json['status'] ?? '',
      serviceId: json['service_id'] ?? 0,
      providerId: json['provider_id'] ?? 0,
      customerId: json['customer_id'] ?? 0,
      bidId: json['bid_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      service: ProviderServiceModel.fromJson(json['service'] ?? {}),
      bid: ProviderBidModel.fromJson(json['bid'] ?? {}),
    );
  }
}

class ProviderServiceModel {
  final int id;
  final String title;
  final String description;
  final dynamic price;
  final String location;
  final String priceType;
  final String currency;
  final String level;
  final List<ProviderServiceImageModel> images;

  ProviderServiceModel({
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

  factory ProviderServiceModel.fromJson(Map<String, dynamic> json) {
    return ProviderServiceModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      location: json['location'] ?? '',
      priceType: json['priceType'] ?? '',
      currency: json['currency'] ?? '',
      level: json['level'] ?? '',
      images: List<ProviderServiceImageModel>.from(
        (json['images'] ?? [])
            .map((x) => ProviderServiceImageModel.fromJson(x)),
      ),
    );
  }
}

class ProviderServiceImageModel {
  final int id;
  final String name;
  final String path;

  ProviderServiceImageModel({
    required this.id,
    required this.name,
    required this.path,
  });

  factory ProviderServiceImageModel.fromJson(Map<String, dynamic> json) {
    return ProviderServiceImageModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      path: json['path'] ?? '',
    );
  }
}

class ProviderBidModel {
  final int id;
  final dynamic amount;

  ProviderBidModel({
    required this.id,
    required this.amount,
  });

  factory ProviderBidModel.fromJson(Map<String, dynamic> json) {
    return ProviderBidModel(
      id: json['id'] ?? 0,
      amount: json['amount'] ?? 0,
    );
  }
}
