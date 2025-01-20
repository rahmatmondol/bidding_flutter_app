import 'package:dirham_uae/app/components/custom_appBar.dart';
import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/app/modules/provider/home/controllers/home_controller.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AllCategoryView extends GetView<HomeController> {
  const AllCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.only(top: 0).copyWith(
            left: 15.r,
            right: 15.r,
          ),
          decoration: BoxDecoration(gradient: buildCustomGradient()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeaderBar(title: 'All Category'),
              gapHeight(size: 5),
              Text(
                "The services we provide are given below. If you want, you can find your favorite service from this list",
                style: kSubtitleStyle,
              ),
              gapHeight(size: 20),
              Text(
                "Categories contain subcategories",
                style: kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
              ),
              Obx(() => controller.isGetCategoriesloading.value
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller
                              .getCategoriesDataModel.value.data?.length ??
                          0,
                      itemBuilder: (context, index) {
                        final category = controller
                            .getCategoriesDataModel.value.data![index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.r),
                          child: CustomButton(
                            bgColor: LightThemeColors.secounderyColor,
                            ontap: () {
                              Get.toNamed(Routes.ALL_SUB_CATEGORY,
                                  arguments: category.id);
                            },
                            widget: Row(
                              children: [
                                Image.asset(Img.carIcon),
                                gapWidth(size: 5),
                                Expanded(
                                  child: Text(
                                    category.name ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: kSubtitleStyle.copyWith(
                                      color: LightThemeColors.whiteColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  color: LightThemeColors.whiteColor,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
