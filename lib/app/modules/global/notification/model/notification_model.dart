class NotificationModel {
  final String id;
  final String createdAt;
  final Map<String, dynamic> data;
  final dynamic readAt; // Changed to dynamic to handle both bool and String
  final String title;

  NotificationModel({
    required this.id,
    required this.createdAt,
    required this.data,
    required this.readAt,
    required this.title,
  });

  bool get isRead => readAt != null && readAt != false;

  factory NotificationModel.fromJson(Map<dynamic, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      createdAt: json['created_at'] ?? '',
      data: Map<String, dynamic>.from(json['data'] ?? {}),
      readAt: json['read_at'],
      // Store raw value
      title: json['title'] ?? '',
    );
  }
}
