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

  @override
  Widget build(BuildContext context) {
    print('FavoriteServiceView: build method called');
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
              print(
                  'FavoriteServiceView: Number of favorite services: $itemCount');
              return Text(
                "You have saved $itemCount ${itemCount == 1 ? 'service' : 'services'} as favorites",
                style: kSubtitleStyle.copyWith(fontWeight: FontWeight.bold),
              );
            }),
            gapHeight(size: 10),
            Expanded(
              child: Obx(() {
                print('FavoriteServiceView: Rebuild triggered by Obx');
                print(
                    'FavoriteServiceView: isLoading: ${controller.isLoading.value}');
                print(
                    'FavoriteServiceView: favoriteServices length: ${controller.favoriteServices.length}');

                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.favoriteServices.isEmpty) {
                  print('FavoriteServiceView: No favorite services found');
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No favorite services yet',
                          style: kSubtitleStyle,
                        ),
                        gapHeight(size: 8),
                        Text(
                          'Add services to your favorites to see them here',
                          style: kSubtitleStyle.copyWith(
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                print(
                    'FavoriteServiceView: Building ListView with ${controller.favoriteServices.length} items');
                return RefreshIndicator(
                  onRefresh: () => controller.fetchWishlistedItems(),
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    padding: EdgeInsets.zero,
                    itemCount: controller.favoriteServices.length,
                    itemBuilder: (context, index) {
                      final item = controller.favoriteServices[index];
                      final service = item.service;

                      print('FavoriteServiceView: Building item $index');
                      print(
                          'FavoriteServiceView: Service exists: ${service != null}');

                      if (service == null) {
                        print(
                            'FavoriteServiceView: Skipping null service at index $index');
                        return const SizedBox();
                      }

                      print(
                          'FavoriteServiceView: Building card for service ${service.id}');
                      print(
                          'FavoriteServiceView: Service title: ${service.title}');

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
                          price:
                              '${service.currency ?? 'USD'} ${service.price?.toString() ?? 'N/A'}',
                          skill: service.skills?.join(', ') ?? 'N/A',
                          isWishlisted: controller
                                  .wishlistedItems[service.id.toString()] ??
                              false,
                          // onWishlistTap: () {
                          //   if (service.id != null) {
                          //     controller.createWishlist(
                          //       service.id.toString(),
                          //       accountDetailsController
                          //               .customerInfo.value?.id ??
                          //           0,
                          //     );
                          //   }
                          // },
                          onWishlistTap: () {
                            if (service.id != null) {
                              // Find the wishlist item for this service
                              final wishlistItem = controller.favoriteServices
                                  .firstWhereOrNull(
                                      (item) => item.service?.id == service.id);

                              if (wishlistItem != null) {
                                // If it exists in wishlist, delete it using the wishlist ID
                                controller.deleteWishlist(
                                    wishlistItem.id!, service.id.toString());
                              } else {
                                // If it doesn't exist in wishlist, create it
                                controller.createWishlist(
                                  service.id.toString(),
                                  accountDetailsController
                                          .customerInfo.value?.id ??
                                      0,
                                );
                              }
                            }
                          },
                          onTap: () =>
                              Get.to(() => FavoriteDetailsView(service)),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
