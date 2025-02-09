import 'package:dirham_uae/app/modules/customer/customer_booking/views/customer_booking_view.dart';
import 'package:dirham_uae/app/modules/customer/customer_home/views/customer_home_view.dart';
import 'package:dirham_uae/app/modules/customer/customer_inbox/views/customer_inbox_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global/add_auction/views/add_auction_view.dart';
import '../../../global/auction/views/auction_view.dart';
import '../../../global/profile/profile_view_both/views/profile_data_view.dart';
import '../../customer_add_service/views/customer_add_service_view.dart';

class CustomerNavBarController extends GetxController {
  final RxInt currentTab = 0.obs;
  final List<Widget> navScreens = [
    CustomerHomeView(),
    CustomerInboxView(),
    CustomerAddServiceView(),
    CustomerAddAuctionView(),
    CustomerBookingView(),
    CustomerAuctionView(),
    CustomerProfileView(),
  ];

  Widget get currentScreen => navScreens[currentTab.value];

  // SetCurrentTab Method
  void setCurrentTab(int newTab) {
    currentTab.value = newTab;
    update();
  }

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
