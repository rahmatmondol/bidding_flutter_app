import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirham_uae/app/components/custom_appBar.dart';
import 'package:dirham_uae/app/modules/provider/home/models/provider_service_model.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/utils/global_variable/my_scaffold_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

import '../../../../../config/theme/my_images.dart';
import '../../../../../config/theme/my_styles.dart';
import '../../../../../utils/global_variable/divider.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/full_map_view.dart';
import '../../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/description_controller.dart';

class DescriptionView extends GetView<DescriptionController> {
  final Service data;

  DescriptionView(this.data, {Key? key}) : super(key: key) {}

  final HomeController homeController = Get.put(HomeController());

  final controller = Get.put(DescriptionController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: MyScaffoldBackground(
        size: size,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeaderBar(title: 'Detail Info'),
                gapHeight(size: 20.0.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: Text(
                    data.title.toString(),
                    style: kTitleTextstyle.copyWith(fontSize: 22.0.sp),
                  ),
                ),
                gapHeight(size: 20.0.h),
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
                      Row(
                        children: [
                          Container(
                            width: 200, // Fixed width
                            child: Text(
                              data.location.toString(),
                              style: TextStyle(color: Colors.grey[400]),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                gapHeight(size: 10.0.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: Row(
                    children: [
                      Text(
                        'Posted at: ',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                      Text(
                        DateFormat('MMM dd, yyyy')
                            .format(DateTime.parse(data.createdAt.toString())),
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),
                gapHeight(size: 10.0.h),

                Container(
                  height: 280.0,
                  color: LightThemeColors.secounderyColor,
                  width: size.width,
                  child: Stack(
                    children: [
                      Obx(() {
                        print('Current index: ${controller.currenIndex.value}');
                        print('Images length: ${controller.images.length}');
                        return SizedBox(
                          width: size.width,
                          height: 280.0,
                          child: data.images != null && data.images!.isNotEmpty
                              ? Image.network(
                                  data.images![controller.currenIndex.value]
                                          .path ??
                                      '',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    print('Error loading image: $error');
                                    return const Icon(Icons.error, size: 50);
                                  },
                                )
                              : Center(child: const Text("No image available")),
                        );
                      }),
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
                                  padding: EdgeInsets.only(right: 5.0),
                                  child: InkWell(
                                    onTap: () =>
                                        controller.currenIndex.value = index,
                                    child: Container(
                                      height: 40.0,
                                      width: 60.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: LightThemeColors.grayColor
                                            .withOpacity(.5),
                                        border: Border.all(
                                          color: LightThemeColors.primaryColor,
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
                // ******Describe*********
                gapHeight(size: 10.0.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: ReadMoreText(
                    data.description.toString(),
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: Text(
                    "Skill and Expertise",
                    style: kTitleTextstyle.copyWith(fontSize: 15.0.sp),
                  ),
                ),
                gapHeight(size: 7.0.h),
                //*********Skills list********* */
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: Wrap(
                    spacing: 8.0.w, // Horizontal space between containers
                    runSpacing: 8.0.h, // Vertical space between containers
                    children: _buildSkillContainers(data.skills),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                //   child: Container(
                //     padding: EdgeInsets.only(
                //         left: 8.0.w, right: 8.0.w, top: 3.0.h, bottom: 3.0.h),
                //     decoration: BoxDecoration(
                //       color: LightThemeColors.grayColor,
                //       borderRadius: BorderRadius.circular(10.0.r),
                //     ),
                //     child: Text(
                //       // If skills is a JSON string, parse it first
                //       data.skills != null
                //           ? (data.skills is String
                //                   ? List<String>.from(json.decode(data.skills!))
                //                   : data.skills as List<String>)
                //               .join(", ") // Join with comma and space
                //           : "No skills",
                //     ),
                //   ),
                // ),
                divider,
                // ***********Active on this job ***********
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: Text(
                    "Active on this job",
                    style: kTitleTextstyle.copyWith(fontSize: 15.5.sp),
                  ),
                ),
                gapHeight(size: 2.0.h),
                //*********************** */
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: Row(
                    children: [
                      Image.asset(
                        Img.timeIcon,
                        scale: 4.5,
                      ),
                      gapWidth(size: 5.0.w),
                      Row(
                        children: [
                          Text(
                            DateFormat('MM dd yyyy, hh:mm aaa').format(
                                DateTime.parse(data.createdAt.toString())),
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                gapHeight(size: 8.0.w),
                // ***********Provider information ***********
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: Text(
                    "Provider information",
                    style: kTitleTextstyle.copyWith(fontSize: 15.0.sp),
                  ),
                ),
                gapHeight(size: 8.0.h),
                // ***********Roww************ */

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: Row(
                    //mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30.0,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: data.customer?.profile?.image ?? '',
                                fit: BoxFit.cover,
                                width: 60.0,
                                height: 60.0,
                                placeholder: (context, url) =>
                                    Image.asset(Img.personIcon),
                                errorWidget: (context, url, error) =>
                                    Image.asset(Img.personIcon),
                              ),
                            ),
                          ),
                          // CircleAvatar(
                          //   radius: 30.0,
                          //   backgroundImage: NetworkImage(
                          //       data.customer?.profile?.image ?? ''),
                          // ),
                          gapWidth(size: 10.0.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.customer?.name ?? 'No Name',
                                style: kSubtitleStyle,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Joined At : ',
                                    style: kSubtitleStyle,
                                  ),
                                  Text(
                                    DateFormat('MM dd yyyy').format(
                                        DateTime.parse(data.customer!.createdAt
                                            .toString())),
                                    style: kSubtitleStyle,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.message_outlined,
                            color: Colors.blue,
                          ))
                    ],
                  ),
                ),
                // ***********What’s Nearby***********
                gapHeight(size: 8.0.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: Text(
                    "What’s Nearby",
                    style: kTitleTextstyle.copyWith(fontSize: 15.0.sp),
                  ),
                ),
                gapHeight(size: 8.0.h),

                // *********Container************
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  //*******Frist Container******* */
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

                        Container(
                          height: size.height / 5.7,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                  double.tryParse(data.latitude ?? "0") ?? 0.0,
                                  double.tryParse(data.longitude ?? "0") ?? 0.0,
                                ),
                                zoom: 10.5,
                              ),
                              markers: {
                                Marker(
                                  markerId: MarkerId("Source"),
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

                        // Container(

                        //   height: size.height / 7,
                        //   width: size.width,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(5.0.r),
                        //     // image: DecorationImage(
                        //     //   image: AssetImage(Images.img1),
                        //     // ),
                        //   ),
                        //   child: GoogleMap(
                        //     initialCameraPosition: CameraPosition(
                        //       target: sourseLocation,
                        //       zoom: 10.5,
                        //     ),
                        //     markers: {
                        //       Marker(
                        //         markerId: MarkerId("Source"),
                        //         position: sourseLocation,
                        //       )
                        //     },
                        //   ),
                        // ),
                        gapHeight(size: 12.0.h),
                        //************* */
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 8.5,
                                backgroundColor:
                                    LightThemeColors.whiteColor.withOpacity(.7),
                                child: CircleAvatar(
                                  radius: 6.5,
                                  backgroundColor: LightThemeColors
                                      .secounderyColor
                                      .withOpacity(.6),
                                  child: CircleAvatar(
                                    radius: 4.5,
                                    backgroundColor: LightThemeColors.whiteColor
                                        .withOpacity(.7),
                                  ),
                                ),
                              ),
                              gapWidth(size: 7.0.w),
                              Expanded(
                                child: Text(
                                  data.location.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: kSubtitleStyle,
                                ),
                              ),
                            ],
                          ),
                        ),

                        //************************ */

                        Divider(
                          color: LightThemeColors.grayColor,
                          thickness: 1.0,
                        ),
                        //********************* */

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                          child: Row(
                            children: [
                              Text('Me: '),
                              Icon(
                                Icons.location_on,
                                color: LightThemeColors.redColor,
                                size: 20,
                              ),
                              gapWidth(size: 5.0.w),
                              Obx(() {
                                final location =
                                    homeController.currentLocation.value;
                                return Text(
                                  location != null
                                      ? "${location.locality}, ${location.country}"
                                      : "UAE, Dubai",
                                  style: kSubtitleStyle,
                                );
                              }),
                            ],
                          ),
                        ),
                        //********************** */
                        divider,

                        GestureDetector(
                          onTap: () {
                            final lat =
                                double.tryParse(data.latitude ?? "0") ?? 0.0;
                            final lng =
                                double.tryParse(data.longitude ?? "0") ?? 0.0;

                            Get.to(() => FullMapView(
                                  latitude: lat,
                                  longitude: lng,
                                  location: data.location ?? "",
                                ));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                            child: Container(
                              height: size.height / 14,
                              width: size.width,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: LightThemeColors.whiteColor,
                                ),
                                borderRadius: BorderRadius.circular(15.0.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 12.0.w,
                                  right: 10.0.w,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'View Map',
                                      style: kTitleTextstyle,
                                    ),
                                    gapWidth(size: 21.0.w),
                                    Text(
                                      'Find your destination',
                                      style: kSubtitleStyle.copyWith(
                                          fontSize: 11.2.sp),
                                    ),
                                    Image.asset(
                                      Img.arrowIcon,
                                      scale: 3.8,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        divider,
                        // ********* apply section *******
                        gapHeight(size: 5.0.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7.0),
                          child: CustomButton(
                            bgColor: LightThemeColors.primaryColor,
                            ontap: () => Get.toNamed(
                              Routes.APPLY,
                              arguments: {
                                'currency': data.currency,
                                'price': data.price,
                                'priceType': data.priceType,
                                'serviceId': data.id,
                                'title': data.title,
                                'description': data.description,
                                'createdAt': data.createdAt,
                                'skills': data.skills is String
                                    ? List<String>.from(
                                        json.decode(data.skills!))
                                    : data.skills as List<String>,
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
    );
  }

  List<Widget> _buildSkillContainers(dynamic skills) {
    if (skills == null) {
      return [_buildSkillContainer("No skills")];
    }

    List<String> skillsList;
    if (skills is String) {
      try {
        skillsList = List<String>.from(json.decode(skills));
      } catch (e) {
        return [_buildSkillContainer("Invalid skills format")];
      }
    } else if (skills is List) {
      skillsList = List<String>.from(skills);
    } else {
      return [_buildSkillContainer("Invalid skills format")];
    }

    return skillsList.map((skill) => _buildSkillContainer(skill)).toList();
  }

  Widget _buildSkillContainer(String skill) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 3.0.h),
      decoration: BoxDecoration(
        color: LightThemeColors.grayColor,
        borderRadius: BorderRadius.circular(10.0.r),
      ),
      child: Text(skill.trim()),
    );
  }
}
