import 'package:dirham_uae/app/modules/provider/favorite_service/views/favorite_service_view.dart';
import 'package:dirham_uae/app/modules/provider/home/views/home_view.dart';
import 'package:dirham_uae/app/modules/provider/inbox/views/inbox_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global/profile/profile_view_both/views/profile_data_view.dart';
import '../../booking/views/provider_booking_view.dart';

class NavBarController extends GetxController {
  final RxInt currentTab = 0.obs;
  final List<Widget> navScreens = [
    HomeView(),
    InboxView(),
    ProviderBookingView(),
    FavoriteServiceView(),
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
