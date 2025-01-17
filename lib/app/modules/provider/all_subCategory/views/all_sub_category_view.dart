import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../components/custom_appBar.dart';
import '../controllers/all_sub_category_controller.dart';

class AllSubCategoryView extends GetView<AllSubCategoryController> {
  const AllSubCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.only(top: 0).copyWith(
          left: 15.r,
          right: 15.r,
        ),
        decoration: BoxDecoration(gradient: buildCustomGradient()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeaderBar(title: 'All Sub Category'),
            gapHeight(size: 5),
            Text(
              "The services we provide are given below. If you want, you can find your favorite service from this list",
              style: kSubtitleStyle,
            ),
            gapHeight(size: 20),
            Obx(
              () => controller.isSubCategoryLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.2.r,
                        crossAxisSpacing: 8.r,
                        mainAxisSpacing: 8.r,
                      ),
                      itemCount:
                          controller.subCategoryModel.value.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final subcategory =
                            controller.subCategoryModel.value.data![index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.r),
                          child: CustomButton(
                            bgColor: LightThemeColors.secounderyColor,
                            ontap: () {
                              print('🔘 Subcategory button tapped');
                              print('📌 Subcategory ID: ${subcategory.id}');

                              // Pass the subcategory ID when navigating to services
                              Get.toNamed(
                                Routes.SERVICES,
                                arguments: subcategory.id,
                              );
                              print('🚀 Navigation completed');
                            },
                            widget: Row(
                              children: [
                                Image.asset(Img.carIcon),
                                gapWidth(size: 5),
                                Expanded(
                                  child: Text(
                                    subcategory.name ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: kSubtitleStyle.copyWith(
                                      color: LightThemeColors.whiteColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
