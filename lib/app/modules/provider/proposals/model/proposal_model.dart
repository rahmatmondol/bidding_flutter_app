class Bid {
  final int id;
  final double amount;
  final String message;
  final String type;
  final String status;
  final int serviceId;
  final int providerId;
  final int customerId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Bid({
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
  });

  factory Bid.fromJson(Map<String, dynamic> json) {
    return Bid(
      id: json['id'] ?? 0,
      amount: (json['amount'] is num)
          ? (json['amount'] as num).toDouble()
          : double.tryParse(json['amount'].toString()) ?? 0.0,
      message: json['message'] ?? '',
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      serviceId: json['service_id'] ?? 0,
      providerId: json['provider_id'] ?? 0,
      customerId: json['customer_id'] ?? 0,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }
}
