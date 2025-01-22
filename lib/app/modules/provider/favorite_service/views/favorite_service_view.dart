import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../config/theme/my_styles.dart';
import '../../../../components/popular_service_card.dart';
import '../../../global/profile/account_details/controllers/account_details_controller.dart';
import '../controllers/favorite_service_controller.dart';
import 'favorite_details_post_view.dart';

class FavoriteServiceView extends GetView<FavoriteServiceController> {
  FavoriteServiceView({Key? key}) : super(key: key);

  final CustomerAccountDetailsController accountDetailsController =
      Get.put(CustomerAccountDetailsController());

  // final accountDetails = accountDetailsController.customerInfo.value;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top + 20.r,
          left: 15.r,
          right: 15.r,
        ),
        decoration: BoxDecoration(gradient: buildCustomGradient()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Favorite Services',
                style: kTitleTextstyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
            gapHeight(size: 20),
            Obx(() {
              final itemCount = controller.favoriteServices.length;
              return Text(
                "You have saved $itemCount ${itemCount == 1 ? 'service' : 'services'} as favorites",
                style: kSubtitleStyle.copyWith(fontWeight: FontWeight.bold),
              );
            }),
            gapHeight(size: 10),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.favoriteServices.isEmpty) {
                  return Center(
                    child: Text(
                      'No favorite services yet',
                      style: kSubtitleStyle,
                    ),
                  );
                }

                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: controller.favoriteServices.length,
                  itemBuilder: (context, index) {
                    final item = controller.favoriteServices[index];
                    final service = item.service;

                    if (service == null) return const SizedBox();

                    return Container(
                      height: size.height * 0.25.h,
                      padding: EdgeInsets.only(bottom: 10.r),
                      child: PopularServiceCard(
                        size: size,
                        name: service.title ?? 'N/A',
                        location: service.location ?? 'N/A',
                        description: service.description ?? 'N/A',
                        priceLevel:
                            '${service.priceType ?? 'N/A'} - ${service.level ?? 'N/A'}',
                        price: service.price?.toString() ?? 'N/A',
                        skill: service.skills?.join(', ') ?? 'N/A',
                        isWishlisted:
                            controller.wishlistedItems[service.id.toString()] ??
                                false,
                        onWishlistTap: () {
                          if (service.id != null) {
                            controller.toggleWishlist(
                              service.id.toString(),
                              accountDetailsController.customerInfo.value?.id ??
                                  0,
                            );
                          }
                        },
                        onTap: () {
                          Get.to(() => FavoriteDetailsView(service));
                        },
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
