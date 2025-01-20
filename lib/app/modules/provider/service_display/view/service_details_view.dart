import 'package:dirham_uae/app/components/custom_appBar.dart';
import 'package:dirham_uae/app/modules/services/models/get_services_models.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/utils/global_variable/my_scaffold_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:readmore/readmore.dart';

import '../../../../../config/theme/my_images.dart';
import '../../../../../config/theme/my_styles.dart';
import '../../../../../utils/global_variable/divider.dart';
import '../../../../components/custom_button.dart';
import '../../../../routes/app_pages.dart';
import '../controller/service_details_controller.dart';

class ServiceDetailsView extends GetView<ServiceDetailsController> {
  final ServiceModel data;

  ServiceDetailsView(this.data, {Key? key}) : super(key: key) {
    final controller = Get.put(ServiceDetailsController());
    controller.setImages(data);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: MyScaffoldBackground(
        size: size,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomHeaderBar(title: 'Detail info'),
                  gapHeight(size: 20.0.h),

                  // Title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: Text(
                      data.title ?? 'No Title',
                      style: kTitleTextstyle.copyWith(fontSize: 22.0.sp),
                    ),
                  ),
                  gapHeight(size: 20.0.h),

                  // Location and category
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: LightThemeColors.whiteColor,
                          size: 15,
                        ),
                        gapWidth(size: 2.0.w),
                        Text(data.category_id?.toString() ?? 'N/A'),
                        gapWidth(size: 30.0.w),
                        Text("Post at 20 minutes ago")
                      ],
                    ),
                  ),

                  gapHeight(size: 10.0.h),

                  // Images section
                  Container(
                    height: 280.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: LightThemeColors.secounderyColor,
                    ),
                    width: size.width,
                    child: Stack(
                      children: [
                        Obx(() {
                          return SizedBox(
                            width: size.width,
                            height: 280.0,
                            child: controller.images.isNotEmpty
                                ? Image.network(
                                    controller
                                        .images[controller.currentIndex.value],
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      print('Error loading image: $error');
                                      return const Icon(Icons.error, size: 50);
                                    },
                                  )
                                : Center(
                                    child: const Text("No image available")),
                          );
                        }),

                        // Thumbnail images
                        Positioned(
                          top: 190,
                          left: 150.0,
                          child: SizedBox(
                            height: 80.0,
                            width: size.width,
                            child: ListView.builder(
                              itemCount: data.images?.length ?? 0,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final imageData = data.images?[index];
                                if (imageData?.path != null) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: InkWell(
                                      onTap: () =>
                                          controller.currentIndex.value = index,
                                      child: Container(
                                        height: 40.0,
                                        width: 60.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: LightThemeColors.grayColor
                                              .withOpacity(.5),
                                          border: Border.all(
                                            color:
                                                LightThemeColors.primaryColor,
                                          ),
                                        ),
                                        child: Image.network(
                                          imageData!.path!,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            print('Thumbnail error: $error');
                                            return const Icon(Icons.error,
                                                size: 20);
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Description
                  gapHeight(size: 10.0.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: ReadMoreText(
                      data.description ?? 'No description available',
                      trimLines: 7,
                      colorClickableText: Colors.pink,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: ' Show more',
                      trimExpandedText: ' Show less',
                      lessStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: LightThemeColors.primaryColor,
                      ),
                      moreStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: LightThemeColors.primaryColor),
                    ),
                  ),
                  divider,

                  // Skills section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: Text(
                      "Skills and Expertise",
                      style: kTitleTextstyle.copyWith(fontSize: 15.0.sp),
                    ),
                  ),
                  gapHeight(size: 7.0.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 8.0.w, right: 8.0.w, top: 3.0.h, bottom: 3.0.h),
                      decoration: BoxDecoration(
                        color: LightThemeColors.grayColor,
                        borderRadius: BorderRadius.circular(10.0.r),
                      ),
                      child: Text(
                        // Using getSkillsString() method from ServiceModel
                        data.getSkillsString(),
                      ),
                    ),
                  ),

                  divider,

                  // Active on job section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: Text(
                      "Active on this job",
                      style: kTitleTextstyle.copyWith(fontSize: 15.5.sp),
                    ),
                  ),
                  gapHeight(size: 2.0.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: Row(
                      children: [
                        Image.asset(
                          Img.timeIcon,
                          scale: 4.5,
                        ),
                        gapWidth(size: 5.0.w),
                        Text(
                          "10 minutes ago",
                          style: kSubtitleStyle,
                        ),
                      ],
                    ),
                  ),
                  gapHeight(size: 8.0.w),

                  // What's Nearby section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: Text(
                      "What's Nearby",
                      style: kTitleTextstyle.copyWith(fontSize: 15.0.sp),
                    ),
                  ),
                  gapHeight(size: 8.0.h),

                  // Map container
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: Container(
                      height: size.height / 2.2,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: LightThemeColors.secounderyColor,
                        borderRadius: BorderRadius.circular(5.0.r),
                      ),
                      child: Column(
                        children: [
                          gapHeight(size: 3.0.h),

                          // Google Map
                          Container(
                            height: size.height / 5.7,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                    double.tryParse(data.latitude ?? "0") ??
                                        0.0,
                                    double.tryParse(data.longitude ?? "0") ??
                                        0.0,
                                  ),
                                  zoom: 10.5,
                                ),
                                markers: {
                                  Marker(
                                    markerId: const MarkerId("Source"),
                                    position: LatLng(
                                      double.tryParse(data.latitude ?? "0") ??
                                          0.0,
                                      double.tryParse(data.longitude ?? "0") ??
                                          0.0,
                                    ),
                                  )
                                },
                              ),
                            ),
                          ),

                          gapHeight(size: 12.0.h),

                          // Location display
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 8.5,
                                  backgroundColor: LightThemeColors.whiteColor
                                      .withOpacity(.7),
                                  child: CircleAvatar(
                                    radius: 6.5,
                                    backgroundColor: LightThemeColors
                                        .secounderyColor
                                        .withOpacity(.6),
                                    child: CircleAvatar(
                                      radius: 4.5,
                                      backgroundColor: LightThemeColors
                                          .whiteColor
                                          .withOpacity(.7),
                                    ),
                                  ),
                                ),
                                gapWidth(size: 7.0.w),
                                Expanded(
                                  child: Text(
                                    data.location ?? 'Location not available',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: kSubtitleStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Divider(
                            color: LightThemeColors.grayColor,
                            thickness: 1.0,
                          ),

                          divider,

                          // Bid button
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 7.0),
                            child: CustomButton(
                              bgColor: LightThemeColors.primaryColor,
                              ontap: () => Get.toNamed(
                                Routes.APPLY,
                                arguments: {
                                  'serviceId': data.id,
                                  'title': data.title,
                                  'description': data.description,
                                  'createdAt': DateTime.parse(data.created_at!),
                                  'skills': data.getSkillsList(),
                                },
                              ),
                              widget: Text(
                                "Bid now",
                                style: kTitleTextstyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
