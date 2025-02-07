import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../../../global/profile/account_details/controllers/account_details_controller.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  late DatabaseReference _notificationsRef;
  final CustomerAccountDetailsController customerAccountDetailsController =
      Get.find<CustomerAccountDetailsController>();

  // Observable variables
  final notifications = <NotificationModel>[].obs;
  var isNotificationLoading = true.obs;
  final userId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeUserId();
    _initializeFirebase();
  }

  void _initializeUserId() {
    try {
      final customerInfo = customerAccountDetailsController.customerInfo.value;
      if (customerInfo?.id != null) {
        userId.value = 'user_${customerInfo!.id}';
        print('Initialized userId: ${userId.value}');
      } else {
        print('Customer ID is null');
      }
    } catch (e) {
      print('Error getting customer ID: $e');
    }
  }

  void _initializeFirebase() {
    try {
      print("Initializing Firebase...");
      _notificationsRef = _database.ref('notifications/${userId.value}');
      _listenToNotifications();
    } catch (e) {
      print("Firebase initialization error: $e");
      isNotificationLoading.value = false;
    }
  }

  String getValidImageUrl(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return Img.personImg;
    }

    // Replace test domain with production if needed
    if (imageUrl.contains('bedding-api.test')) {
      imageUrl =
          imageUrl.replaceAll('bedding-api.test', 'your-production-domain.com');
    }

    // Ensure HTTPS
    if (imageUrl.startsWith('http://')) {
      imageUrl = imageUrl.replaceFirst('http://', 'https://');
    }

    return imageUrl;
  }

  bool isNotificationRead(Map<String, dynamic> data) {
    return data['read_at'] != null && data['read_at'] != false;
  }

  void _listenToNotifications() {
    print("Starting notification listener for user: ${userId.value}");

    _notificationsRef.onValue.listen(
      (event) {
        try {
          if (event.snapshot.value != null) {
            final Map<dynamic, dynamic> values =
                event.snapshot.value as Map<dynamic, dynamic>;

            final List<NotificationModel> newNotifications = [];

            values.forEach((key, value) {
              try {
                if (value is Map) {
                  // Validate and get the created_at date
                  String createdAt = value['created_at'] ?? '';
                  try {
                    _parseDateTime(createdAt); // Validate the date format

                    // Create notification object
                    final Map<String, dynamic> notificationData = {
                      'id': key,
                      'created_at': createdAt,
                      'data': value['data'] ?? {},
                      'read_at': value['read_at'],
                      'title': value['title'],
                    };

                    final notification =
                        NotificationModel.fromJson(notificationData);
                    newNotifications.add(notification);
                  } catch (dateError) {
                    print(
                        "Invalid date format for notification $key: $dateError");
                  }
                }
              } catch (e) {
                print("Error processing individual notification: $e");
              }
            });

            // Sort notifications by date (newest first)
            newNotifications.sort((a, b) {
              try {
                return _parseDateTime(b.createdAt)
                    .compareTo(_parseDateTime(a.createdAt));
              } catch (e) {
                print("Error sorting dates: $e");
                return 0; // Keep original order if date comparison fails
              }
            });

            notifications.value = newNotifications;
          } else {
            notifications.clear();
          }
        } catch (e) {
          print("Error processing notifications data: $e");
          notifications.clear();
        } finally {
          isNotificationLoading.value = false;
        }
      },
      onError: (error) {
        print("Firebase listener error: $error");
        isNotificationLoading.value = false;
      },
      cancelOnError: false,
    );
  }

  // Method to handle notification tap
  void onNotificationTap(String notificationId) {
    markAsRead(notificationId);
    // Future: Add navigation to details page here
  }

  void markAsRead(String notificationId) {
    try {
      _notificationsRef
          .child(notificationId)
          .update({'read_at': DateTime.now().toIso8601String()});
    } catch (e) {
      print("Error marking notification as read: $e");
    }
  }

  void markAllAsRead() {
    try {
      final Map<String, Object?> updates = {};
      for (var notification in notifications) {
        if (!notification.readAt) {
          updates['${notification.id}/read_at'] =
              DateTime.now().toIso8601String();
        }
      }
      if (updates.isNotEmpty) {
        _notificationsRef.update(updates);
      }
    } catch (e) {
      print("Error marking all notifications as read: $e");
    }
  }

  void deleteNotification(String notificationId) {
    try {
      _notificationsRef.child(notificationId).remove();
    } catch (e) {
      print("Error deleting notification: $e");
    }
  }

  DateTime _parseDateTime(String dateStr) {
    try {
      // First try parsing as is
      return DateTime.parse(dateStr);
    } catch (e) {
      try {
        // Split the date and time
        List<String> parts = dateStr.split(' ');
        String date = parts[0];
        String time = parts[1];

        // Split date components
        List<String> dateParts = date.split('-');
        // Ensure day and month are 2 digits
        String day = dateParts[2].padLeft(2, '0');
        String month = dateParts[1].padLeft(2, '0');
        String year = dateParts[0];

        // Reconstruct in ISO format
        String isoDate = '$year-$month-$day $time';
        return DateTime.parse(isoDate);
      } catch (e) {
        print("Error parsing date '$dateStr': $e");
        return DateTime.now(); // Fallback to current time
      }
    }
  }

  String formatNotificationTime(String createdAt) {
    try {
      final DateTime dateTime = _parseDateTime(createdAt);
      final DateTime now = DateTime.now();
      final Duration difference = now.difference(dateTime);

      // For times less than 1 minute ago
      if (difference.inMinutes < 1) {
        return 'Just now';
      }
      // For times less than 1 hour ago
      else if (difference.inMinutes < 60) {
        return '${difference.inMinutes}m ago';
      }
      // For times less than 24 hours ago
      else if (difference.inHours < 24) {
        return '${difference.inHours}h ago';
      }
      // For times less than 7 days ago
      else if (difference.inDays < 7) {
        return '${difference.inDays}d ago';
      }
      // For times less than 4 weeks ago
      else if (difference.inDays < 28) {
        final weeks = (difference.inDays / 7).floor();
        return '${weeks}w ago';
      }
      // For times less than 12 months ago
      else if (difference.inDays < 365) {
        final months = (difference.inDays / 30).floor();
        return '${months}mo ago';
      }
      // For times more than a year ago
      else {
        final years = (difference.inDays / 365).floor();
        return '${years}y ago';
      }
    } catch (e) {
      print("Error formatting date: $e");
      return createdAt; // Return original string if parsing fails
    }
  }
}
