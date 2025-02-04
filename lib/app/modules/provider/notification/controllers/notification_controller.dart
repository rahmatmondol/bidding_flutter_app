// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:get/get.dart';
//
// import '../model/notification_model.dart';
//
// class NotificationController extends GetxController {
//   final FirebaseDatabase _database = FirebaseDatabase.instance;
//   late DatabaseReference _notificationsRef;
//
//   // Observable list to store notifications
//   final notifications = <NotificationModel>[].obs;
//   var isNotificationLoading = true.obs;
//   final String userId = 'user_2';
//
//   @override
//   void onInit() {
//     super.onInit();
//     try {
//       print("NotificationController initialized");
//       print("Firebase Database URL: ${FirebaseDatabase.instance.databaseURL}");
//       print("Firebase App Name: ${Firebase.app().name}");
//       print("Firebase Options: ${Firebase.app().options.toString()}");
//       _initializeFirebase();
//     } catch (e, stackTrace) {
//       print("Firebase Initialization Error: $e");
//       print("Stack Trace: $stackTrace");
//     }
//   }
//
//   void _initializeFirebase() {
//     // Initialize the reference to your notifications
//     _notificationsRef = _database.ref('notifications/$userId');
//     _listenToNotifications();
//   }
//
//   void _listenToNotifications() {
//     print("Starting to listen to notifications for user_2");
//
//     _notificationsRef.onValue.listen((event) {
//       print("Received Firebase event");
//       print("Data received: ${event.snapshot.value}");
//
//       if (event.snapshot.value != null) {
//         print("Data is not null");
//
//         notifications.clear();
//         final Map<dynamic, dynamic> values =
//             event.snapshot.value as Map<dynamic, dynamic>;
//
//         values.forEach((key, value) {
//           notifications.add(NotificationModel.fromJson(
//               {'id': key, ...value as Map<dynamic, dynamic>}));
//         });
//
//         notifications.sort((a, b) => b.createdAt.compareTo(a.createdAt));
//
//         isNotificationLoading.value = false;
//       } else {
//         print("Data is null");
//
//         isNotificationLoading.value = false;
//       }
//     }, onError: (error) {
//       print("Firebase Error: $error");
//       print('Error: $error');
//       isNotificationLoading.value = false;
//     });
//   }
// }

import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../model/notification_model.dart';

class NotificationController extends GetxController {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  late DatabaseReference _notificationsRef;

  // Observable variables
  final notifications = <NotificationModel>[].obs;
  var isNotificationLoading = true.obs;
  final String userId = 'user_2';

  @override
  void onInit() {
    super.onInit();
    _initializeFirebase();
  }

  void _initializeFirebase() {
    try {
      print("Initializing Firebase...");
      _notificationsRef = _database.ref('notifications/$userId');
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

  // String formatNotificationTime(String createdAt) {
  //   try {
  //     final DateTime dateTime = DateTime.parse(createdAt);
  //     final DateTime now = DateTime.now();
  //     final Duration difference = now.difference(dateTime);
  //
  //     if (difference.inMinutes < 60) {
  //       return '${difference.inMinutes}m ago';
  //     } else if (difference.inHours < 24) {
  //       return '${difference.inHours}h ago';
  //     } else if (difference.inDays < 7) {
  //       return '${difference.inDays}d ago';
  //     } else {
  //       return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  //     }
  //   } catch (e) {
  //     print("Date formatting error: $e");
  //     return createdAt;
  //   }
  // }

  void _listenToNotifications() {
    print("Starting notification listener for user: $userId");

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
                  final notification = NotificationModel.fromJson(
                      {'id': key, ...Map<String, dynamic>.from(value)});
                  newNotifications.add(notification);
                }
              } catch (e) {
                print("Error processing individual notification: $e");
              }
            });

            // Sort notifications by date (newest first)
            newNotifications.sort((a, b) => DateTime.parse(b.createdAt)
                .compareTo(DateTime.parse(a.createdAt)));

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

  void markAsRead(String notificationId) {
    try {
      _notificationsRef
          .child(notificationId)
          .update({'read_at': DateTime.now().toIso8601String()});
    } catch (e) {
      print("Error marking notification as read: $e");
    }
  }

  void deleteNotification(String notificationId) {
    try {
      _notificationsRef.child(notificationId).remove();
    } catch (e) {
      print("Error deleting notification: $e");
    }
  }

  String formatNotificationTime(String createdAt) {
    try {
      final DateTime dateTime = DateTime.parse(createdAt);
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
