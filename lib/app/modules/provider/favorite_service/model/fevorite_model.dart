// First, let's create the WishlistModel (wishlist_model.dart):
class FavoriteModel {
  final String? message;
  final int? status;
  final bool? success;
  final FavoriteListData? data;

  FavoriteModel({
    this.message,
    this.status,
    this.success,
    this.data,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        message: json['message'],
        status: json['status'],
        success: json['success'],
        data: json['data'] != null
            ? FavoriteListData.fromJson(json['data'])
            : null,
      );
}

class FavoriteListData {
  final String? serviceId;
  final int? providerId;
  final String? updatedAt;
  final String? createdAt;
  final int? id;

  FavoriteListData({
    this.serviceId,
    this.providerId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory FavoriteListData.fromJson(Map<String, dynamic> json) =>
      FavoriteListData(
        serviceId: json['service_id']?.toString(),
        providerId: json['provider_id'],
        updatedAt: json['updated_at'],
        createdAt: json['created_at'],
        id: json['id'],
      );
}
