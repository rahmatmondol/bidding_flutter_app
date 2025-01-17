import 'package:dirham_uae/app/components/custom_appBar.dart';
import 'package:dirham_uae/utils/global_variable/my_scaffold_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../config/theme/my_styles.dart';
import '../../../components/popular_service_card.dart';
import '../../../routes/app_pages.dart';
import '../../provider/home/widgets/search_bar.dart';
import '../controllers/services_controller.dart';

class ServicesView extends GetView<ServicesController> {
  const ServicesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('🏗️ Building ServicesView');
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: MyScaffoldBackground(
        size: size,
        child: SafeArea(
          child: Obx(
            () {
              print('🔄 Rebuilding Obx widget');
              print(
                  '📊 Loading state: ${controller.isGetServiceloading.value}');
              print(
                  '📊 Filtered services count: ${controller.filteredServices.length}');

              if (controller.isGetServiceloading.value) {
                print('⌛ Showing loading indicator');
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 16, top: 0),
                child: Column(
                  children: [
                    CustomHeaderBar(title: 'Services'),
                    gapHeight(size: 20),
                    ServiceSearchWidget(), // search bar
                    gapHeight(size: 10),
                    Expanded(
                      child: controller.filteredServices.isEmpty
                          ? Center(
                              child: Text(
                                'No services found in this category',
                                style: kSubtitleStyle,
                              ),
                            )
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: controller.filteredServices.length,
                              itemBuilder: (context, index) {
                                final service =
                                    controller.filteredServices[index];
                                print(
                                    '🎯 Building service card for index $index');
                                print(
                                    '📦 Service data: name=${service.title}, id=${service.id}');

                                return Container(
                                  height: size.height * 0.25.h,
                                  padding: EdgeInsets.only(bottom: 10.r),
                                  child: PopularServiceCard(
                                    size: size,
                                    name: service.title ?? '',
                                    location: service.location ?? '',
                                    description: service.description ?? '',
                                    priceLevel: service.level ?? '',
                                    price:
                                        '${service.currency ?? ''} ${service.price ?? ''}',
                                    skill: service.getSkillsString(),
                                    onTap: () => Get.toNamed(
                                        Routes.SERVICE_DESCRIPTION,
                                        arguments: {
                                          'service': service
                                          // your ServiceModel instance
                                        }),
                                    //     Get.toNamed(
                                    //   Routes.SERVICE_DESCRIPTION,
                                    //   arguments: service,
                                    // ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
