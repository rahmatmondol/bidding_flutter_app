// import 'package:dirham_uae/app/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../../utils/urls.dart';
// import '../../../../data/local/my_shared_pref.dart';
// import '../../../../services/base_client.dart';
//
// class ApplyController extends GetxController {
//   RxString amount = "".obs;
//   RxString message = "".obs;
//   late int serviceId;
//   late String title;
//   late String description;
//   late String currency;
//   late double price = 0.0;
//   late String priceType;
//   late List<String> skills;
//   late DateTime createdAt;
//
//   @override
//   void onInit() {
//     super.onInit();
//     final args = Get.arguments;
//     if (args != null) {
//       currency = args['currency'] ?? '';
//       // Convert price to double safely
//       price = (args['price'] ?? 0.0).toDouble();
//       priceType = args['priceType'] ?? '';
//       serviceId = args['serviceId'] ?? 0;
//       title = args['title'] ?? '';
//       description = args['description'] ?? '';
//       // Handle createdAt based on its type
//       if (args['createdAt'] is DateTime) {
//         createdAt = args['createdAt'];
//       } else if (args['createdAt'] is String) {
//         createdAt = DateTime.parse(args['createdAt']);
//       } else {
//         createdAt = DateTime.now();
//       }
//       // createdAt = args['createdAt'] != null
//       //     ? DateTime.parse(args['createdAt'])
//       //     : DateTime.now();
//       skills = List<String>.from(args['skills'] ?? []);
//     }
//   }
//
//   Future<void> submitBid() async {
//     try {
//       final data = {
//         'service_id': serviceId.toString(),
//         'amount': amount.value.toString(),
//         'message': message.value.toString(),
//       };
//
//       print('Sending bid data: $data');
//
//       await BaseClient.safeApiCall(
//         Constants.createBidding,
//         RequestType.post,
//         data: data,
//         headers: {
//           'Authorization':
//               'Bearer ${MySharedPref.getTokenProvider("token-provider".obs).toString()}',
//         },
//         onSuccess: (response) {
//           print('Bid submitted successfully: ${response.data}');
//
//           Get.snackbar(
//             '${response.data['message']}',
//             '${response.data['status']}',
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.green,
//             colorText: Colors.white,
//           );
//           Get.toNamed(Routes.NAV_BAR);
//         },
//         onError: (error) {
//           print(
//               'Bid submission failed: ${error.message}'); // Print error message
//
//           Get.snackbar(
//             'Error',
//             'Failed to submit bid: ${error.message}',
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.red,
//             colorText: Colors.white,
//           );
//         },
//       );
//     } catch (e) {
//       print('Unexpected error: $e'); // Print unexpected errors
//
//       Get.snackbar(
//         'Error',
//         'Unexpected error: ${e.toString()}',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }
// }
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/urls.dart';
import '../../../../data/local/my_shared_pref.dart';
import '../../../../services/base_client.dart';

// class ApplyController extends GetxController {
//   RxString amount = "".obs;
//   RxString message = "".obs;
//   late int serviceId;
//   late String title;
//   late String description;
//   late String currency;
//   late double price = 0.0;
//   late String priceType;
//   late List<String> skills;
//   late DateTime createdAt;
//
//   @override
//   void onInit() {
//     super.onInit();
//     final args = Get.arguments;
//     if (args != null) {
//       currency = args['currency'] ?? '';
//       // Convert price to double safely
//       price = (args['price'] ?? 0.0).toDouble();
//       priceType = args['priceType'] ?? '';
//       serviceId = args['serviceId'] ?? 0;
//       title = args['title'] ?? '';
//       description = args['description'] ?? '';
//       // Handle createdAt based on its type
//       if (args['createdAt'] is DateTime) {
//         createdAt = args['createdAt'];
//       } else if (args['createdAt'] is String) {
//         createdAt = DateTime.parse(args['createdAt']);
//       } else {
//         createdAt = DateTime.now();
//       }
//       // createdAt = args['createdAt'] != null
//       //     ? DateTime.parse(args['createdAt'])
//       //     : DateTime.now();
//       skills = List<String>.from(args['skills'] ?? []);
//     }
//   }
//
//   Future<void> submitBid() async {
//     try {
//       final data = {
//         'service_id': serviceId.toString(),
//         'amount': amount.value.toString(),
//         'message': message.value.toString(),
//       };
//
//       print('Sending bid data: $data');
//
//       await BaseClient.safeApiCall(
//         Constants.createBidding,
//         RequestType.post,
//         data: data,
//         headers: {
//           'Authorization':
//               'Bearer ${MySharedPref.getTokenProvider("token-provider".obs).toString()}',
//         },
//         onSuccess: (response) {
//           print('Bid submitted successfully: ${response.data}');
//
//           Get.snackbar(
//             '${response.data['message']}',
//             '${response.data['status']}',
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.green,
//             colorText: Colors.white,
//           );
//           Get.toNamed(Routes.NAV_BAR);
//         },
//         onError: (error) {
//           print(
//               'Bid submission failed: ${error.message}'); // Print error message
//
//           Get.snackbar(
//             'Error',
//             'Failed to submit bid: ${error.message}',
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.red,
//             colorText: Colors.white,
//           );
//         },
//       );
//     } catch (e) {
//       print('Unexpected error: $e'); // Print unexpected errors
//
//       Get.snackbar(
//         'Error',
//         'Unexpected error: ${e.toString()}',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }
// }

class ApplyController extends GetxController {
  RxString amount = "".obs;
  RxString message = "".obs;

  // Change commission to RxInt
  RxInt commission = 0.obs; // Changed from 'late int commission'

  RxDouble serviceFee = 0.0.obs;
  RxDouble finalAmount = 0.0.obs;
  RxBool isFixedPrice = false.obs;

  late int serviceId;
  late String title;
  late String description;
  late String currency;
  late double price = 0.0;
  late String priceType;
  late List<String> skills;
  late DateTime createdAt;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
      currency = args['currency'] ?? '';
      price = (args['price'] ?? 0.0).toDouble();
      print('Price Type received: ${args['priceType']}');
      priceType = args['priceType'] ?? '';
      print('Price Type set to: $priceType');
      serviceId = args['serviceId'] ?? 0;
      title = args['title'] ?? '';
      description = args['description'] ?? '';
      commission.value = args['commission'] ?? 0; // Modified to use .value

      if (args['createdAt'] is DateTime) {
        createdAt = args['createdAt'];
      } else if (args['createdAt'] is String) {
        createdAt = DateTime.parse(args['createdAt']);
      } else {
        createdAt = DateTime.now();
      }
      skills = List<String>.from(args['skills'] ?? []);

      isFixedPrice.value = priceType.toLowerCase() == 'fixed';
      print('Is Fixed Price: ${isFixedPrice.value}');

      if (isFixedPrice.value) {
        calculateServiceFee(price);
        amount.value = price.toString();
      }
    }
  }

  // Calculate service fee using commission from arguments
  void calculateServiceFee(double bidAmount) {
    serviceFee.value = bidAmount *
        (commission / 100); // Calculate fee based on commission percentage
    finalAmount.value = bidAmount - serviceFee.value;
  }

  // Only allow bid amount changes for non-fixed price
  void onBidAmountChanged(String value) {
    if (!isFixedPrice.value) {
      amount.value = value;
      if (value.isNotEmpty) {
        double bidAmount = double.tryParse(value) ?? 0.0;
        calculateServiceFee(bidAmount);
      } else {
        serviceFee.value = 0.0;
        finalAmount.value = 0.0;
      }
    }
  }

  void clearInputs() {
    amount.value = "";
    message.value = "";
    if (!isFixedPrice.value) {
      serviceFee.value = 0.0;
      finalAmount.value = 0.0;
    }
  }

  Future<void> submitBid() async {
    try {
      // NEW: Use the appropriate amount based on price type
      final bidAmount = isFixedPrice.value ? price.toString() : amount.value;

      final data = {
        'service_id': serviceId.toString(),
        'amount': bidAmount,
        'message': message.value.toString(),
      };

      print('Sending bid data: $data');

      await BaseClient.safeApiCall(
        Constants.createBidding,
        RequestType.post,
        data: data,
        headers: {
          'Authorization':
              'Bearer ${MySharedPref.getTokenProvider("token-provider".obs).toString()}',
        },
        onSuccess: (response) {
          print('Bid submitted successfully: ${response.data}');
          clearInputs();
          Get.snackbar(
            '${response.data['message']}',
            '${response.data['status']}',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.toNamed(Routes.NAV_BAR);
        },
        onError: (error) {
          print('Bid submission failed: ${error.message}');
          Get.snackbar(
            'Error',
            'Failed to submit bid: ${error.message}',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        },
      );
    } catch (e) {
      print('Unexpected error: $e');
      Get.snackbar(
        'Error',
        'Unexpected error: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
