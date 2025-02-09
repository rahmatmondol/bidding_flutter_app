import 'dart:io';

import 'package:dirham_uae/app/components/custom_appBar.dart';
import 'package:dirham_uae/app/components/custom_text_field.dart';
import 'package:dirham_uae/app/modules/provider/home/controllers/home_controller.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:dirham_uae/utils/global_variable/my_scaffold_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../config/theme/my_images.dart';
import '../../../../../utils/global_variable/divider.dart';
import '../../../../components/custom_button.dart';
import '../../../../data/user_service/user_service.dart';
import '../../../../routes/app_pages.dart';
import '../../../customer/customer_home/controllers/customer_home_controller.dart';
import '../../../provider/home/models/get_categories_model.dart';
import '../controllers/add_auction_controller.dart';

class CustomerAddAuctionView extends GetView<CustomerAddAuctionController> {
  CustomerAddAuctionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomerAddAuctionController customerAddAuctionController =
        Get.put(CustomerAddAuctionController());

    final CustomerHomeController customerHomeController =
        Get.put(CustomerHomeController());

    final HomeController homeC = Get.put(HomeController());
    Size size = MediaQuery.sizeOf(context);

    final myBox = Hive.box('mapBox');

    var currentAddress;
    currentAddress = myBox.get("address3");

    return Scaffold(
      body: MyScaffoldBackground(
        size: size,
        child: Obx(() {
          // final categories =
          //     homeC.getCategoriesDataModel.value.data?.category ?? [];

          final categories = homeC.getCategoriesDataModel.value.data ?? [];

          // Find the selected category safely
          Category? selectedCategory;
          if (controller.selectedCategory.value.isNotEmpty) {
            selectedCategory = categories.firstWhereOrNull((category) =>
                category.name == controller.selectedCategory.value);
          }

          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomHeaderBar(title: 'Create a Auction'),
                      Text("Auction Name",
                          style: kTitleTextstyle.copyWith(
                            fontWeight: FontWeight.w600,
                          )),
                      divider,
                      CustomTextField(
                        fillColor: LightThemeColors.scaffoldBackgroundColor,
                        hintText: "Enter Your First name",
                        controller: controller.name.value,
                      ),

                      divider,
                      // *********** Add button****************
                      Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              final pickedFiles =
                                  await ImagePicker().pickMultiImage();
                              if (pickedFiles != null &&
                                  pickedFiles.isNotEmpty) {
                                controller.selectedthumbnail.value = pickedFiles
                                    .map((pickedFile) => XFile(pickedFile.path))
                                    .toList();
                                // controller.customerCreateAuction(
                                //     controller.categooryId ?? 0,
                                //     controller.subCategoryId.toString(),
                                //     controller.selectedCurrency.value,
                                //     controller.selectedPriceType.value,
                                //     controller.selectedLevelList.value);
                                print(controller.customerCreateAuction
                                    .toString());
                              } else {
                                print('Image picked successfully');
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 15.r,
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                color: LightThemeColors.secounderyColor,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Center(child: Text("Add Photos")),
                            ),
                          ),
                          SizedBox(height: 16.r),
                          if (controller.selectedthumbnail.value.isNotEmpty)
                            Wrap(
                              spacing: 8.r,
                              runSpacing: 8.r,
                              children: controller.selectedthumbnail.value
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                final index = entry.key;
                                final file = entry.value;
                                return Stack(
                                  children: [
                                    Container(
                                      width: 100.r,
                                      height: 100.r,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        image: DecorationImage(
                                          image: FileImage(File(file!.path)),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 4.r,
                                      right: 4.r,
                                      child: InkWell(
                                        onTap: () {
                                          controller.selectedthumbnail.value =
                                              List.from(controller
                                                  .selectedthumbnail.value)
                                                ..removeAt(index);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(4.r),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.close,
                                            size: 16.r,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                        ],
                      ),

                      divider,
                      Text(" Auction Description",
                          style: kTitleTextstyle.copyWith(
                            fontWeight: FontWeight.w600,
                          )),
                      //
                      gapHeight(size: 2.0.h),
                      Container(
                        height: size.height * 0.25,
                        // Reduced height since we don't need toolbar
                        decoration: BoxDecoration(
                          color: LightThemeColors.secounderyColor,
                          borderRadius: BorderRadius.circular(10.0.r),
                        ),
                        child: TextField(
                          controller: controller.description.value,
                          style: TextStyle(color: LightThemeColors.whiteColor),
                          maxLines: null,
                          // Allows multiple lines
                          expands: true,
                          // Makes the TextField expand to fill the container
                          textAlignVertical: TextAlignVertical.top,
                          decoration: InputDecoration(
                            hintText: 'Describe your auction...',
                            hintStyle: TextStyle(
                                color: LightThemeColors.whiteColor
                                    .withOpacity(0.5)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0.r),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.all(15),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Skill and Expertise",
                        style: kTitleTextstyle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      gapHeight(size: 2.0.h),
                      Container(
                        decoration: BoxDecoration(
                          color: LightThemeColors.secounderyColor,
                          borderRadius: BorderRadius.circular(10.0.r),
                        ),
                        child: Column(
                          children: [
                            // Tag Input Field
                            Padding(
                              padding: EdgeInsets.all(8.r),
                              child: TextField(
                                controller: controller.tagController.value,
                                style: TextStyle(
                                    color: LightThemeColors.whiteColor),
                                decoration: InputDecoration(
                                  hintText: 'Add up to 5 skills...',
                                  hintStyle: TextStyle(
                                      color: LightThemeColors.whiteColor
                                          .withOpacity(0.5)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: LightThemeColors.grayColor
                                      .withOpacity(0.2),
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.add,
                                        color: LightThemeColors.whiteColor),
                                    onPressed: () {
                                      if (controller.tagController.value.text
                                          .isNotEmpty) {
                                        controller.addTag(controller
                                            .tagController.value.text
                                            .trim());
                                      }
                                    },
                                  ),
                                ),
                                onSubmitted: (value) {
                                  if (value.isNotEmpty) {
                                    controller.addTag(value.trim());
                                  }
                                },
                              ),
                            ),

                            // API Tags Suggestions
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(horizontal: 8.r),
                              child: Obx(() => Row(
                                    children: controller.apiTags
                                        .where((tag) => !controller.selectedTags
                                            .contains(tag))
                                        .take(5)
                                        .map((tag) => Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8.r),
                                              child: InkWell(
                                                onTap: () =>
                                                    controller.addTag(tag),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12.r,
                                                      vertical: 6.r),
                                                  decoration: BoxDecoration(
                                                    color: LightThemeColors
                                                        .grayColor
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.r),
                                                  ),
                                                  child: Text(
                                                    tag,
                                                    style: TextStyle(
                                                        color: LightThemeColors
                                                            .whiteColor),
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  )),
                            ),

                            // Selected Tags
                            Padding(
                              padding: EdgeInsets.all(8.r),
                              child: Obx(() => Wrap(
                                    spacing: 8.r,
                                    runSpacing: 8.r,
                                    children: controller.selectedTags
                                        .map((tag) => Chip(
                                              backgroundColor:
                                                  LightThemeColors.grayColor,
                                              label: Text(
                                                tag,
                                                style: TextStyle(
                                                    color: LightThemeColors
                                                        .whiteColor),
                                              ),
                                              deleteIcon: Icon(
                                                Icons.clear,
                                                color:
                                                    LightThemeColors.whiteColor,
                                                size: 18.r,
                                              ),
                                              onDeleted: () =>
                                                  controller.removeTag(tag),
                                            ))
                                        .toList(),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      divider,
                      Text(
                        "Select Auction Category",
                        style: kTitleTextstyle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      gapHeight(size: 3.0.h),

                      //********Select Auction Category*********

                      Obx(() => Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: LightThemeColors.secounderyColor,
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(
                                  color: LightThemeColors.shadowColor,
                                  offset: Offset(1, 1),
                                  blurRadius: 5,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Center(
                                child: DropdownButton(
                                    dropdownColor: LightThemeColors.primaryColor
                                        .withOpacity(.8),
                                    alignment: Alignment.centerLeft,
                                    value: controller.categoryyIds.value.isEmpty
                                        ? null
                                        : controller.categoryyIds.value,
                                    isExpanded: true,
                                    underline: SizedBox(),
                                    hint: const Text("Choose Category"),
                                    items:
                                        (controller.categoryModel.value.data ??
                                                [])
                                            .map((mapValue) {
                                      return DropdownMenuItem(
                                        value: mapValue.name.toString(),
                                        child: Text(
                                          mapValue.name.toString(),
                                          style: TextStyle(
                                              color:
                                                  LightThemeColors.whiteColor),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      final selectedZone = (controller
                                                  .categoryModel.value.data ??
                                              [])
                                          .firstWhere((zone) =>
                                              zone.name.toString() == newValue);

                                      // Check if the selected zone is not null and has an ID

                                      if (selectedZone != null &&
                                          selectedZone.id != null) {
                                        controller.categoryyIds.value =
                                            newValue.toString();
                                        controller.categooryId =
                                            selectedZone.id;
                                        controller
                                            .getSubCategories(selectedZone.id!);
                                      }
                                    }),
                              ),
                            ),
                          )),
                      gapHeight(size: 3.0.h),
                      Text(
                        "Select Sub Category",
                        style: kTitleTextstyle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      gapHeight(size: 3.0.h),

                      //********Select Sub Category*********

                      Obx(() => Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: LightThemeColors.secounderyColor,
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(
                                  color: LightThemeColors.shadowColor,
                                  offset: Offset(1, 1),
                                  blurRadius: 5,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Center(
                                child: controller.isSubCategoryLoading.value
                                    ? CircularProgressIndicator(
                                        color: LightThemeColors.whiteColor,
                                      )
                                    : DropdownButton(
                                        dropdownColor: LightThemeColors
                                            .primaryColor
                                            .withOpacity(.8),
                                        alignment: Alignment.centerLeft,
                                        value: controller.selectedSubCategoryId
                                                .value.isEmpty
                                            ? null
                                            : controller
                                                .selectedSubCategoryId.value,
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        hint: const Text("Choose Sub Category"),
                                        items: (controller.subCategoryModel
                                                    .value.data ??
                                                [])
                                            .map((mapValue) {
                                          return DropdownMenuItem(
                                            value: mapValue.id.toString(),
                                            child: Text(
                                              mapValue.name.toString(),
                                              style: TextStyle(
                                                  color: LightThemeColors
                                                      .whiteColor),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          controller.selectedSubCategoryId
                                              .value = newValue.toString();
                                          // No need to search for ID since we're using ID as value
                                          controller.subCategoryId =
                                              int.parse(newValue.toString());
                                        },
                                      ),
                              ),
                            ),
                          )),
                      //**********pricing**************** */
                      divider,
                      Row(
                        children: [
                          Text(
                            "Pricing",
                            style: kTitleTextstyle.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          gapWidth(size: 5.0.w),
                          Image.asset(
                            Img.tollIcon,
                            scale: 4,
                          ),
                        ],
                      ),

                      gapHeight(size: 10.0.h),
                      //
                      Text(
                        "Currency",
                        style: kTitleTextstyle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      gapHeight(size: 3.0.h),
                      //********Select Price Type*********
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: LightThemeColors.secounderyColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Center(
                            child: DropdownButton(
                                dropdownColor: LightThemeColors.secounderyColor,
                                alignment: Alignment.centerLeft,
                                value: controller.selectedCurrency.value.isEmpty
                                    ? null
                                    : controller.selectedCurrency.value,
                                style: TextStyle(color: Colors.white),
                                isExpanded: true,
                                underline: SizedBox(),
                                hint: const Text("Choose you currency type"),
                                items:
                                    (controller.currency.value).map((mapValue) {
                                  return DropdownMenuItem(
                                    value: mapValue,
                                    child: Center(
                                        child: Text(mapValue.toString())),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  controller.selectedCurrency.value =
                                      newValue.toString();
                                  print(controller.selectedCurrency.value =
                                      newValue.toString());
                                }),
                          ),
                        ),
                      ),
                      gapHeight(size: 6.0.h),
                      //*********Price Text *************
                      Text(
                        "Price Type",
                        style: kTitleTextstyle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: LightThemeColors.secounderyColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Center(
                            child: DropdownButton(
                                dropdownColor: LightThemeColors.secounderyColor,
                                alignment: Alignment.centerLeft,
                                value:
                                    controller.selectedPriceType.value.isEmpty
                                        ? null
                                        : controller.selectedPriceType.value,
                                isExpanded: true,
                                underline: SizedBox(),
                                hint: const Text("Choose you price type"),
                                style: TextStyle(color: Colors.white),
                                items: (controller.priceTypeList.value)
                                    .map((mapValue) {
                                  return DropdownMenuItem(
                                    value: mapValue,
                                    child: Center(
                                        child: Text(mapValue.toString())),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  controller.selectedPriceType.value =
                                      newValue.toString();
                                  print(controller.selectedPriceType.value =
                                      newValue.toString());
                                }),
                          ),
                        ),
                      ),
                      gapHeight(size: 6.0.h),

                      // ******************************* Price Text **************************** //
                      Text(
                        "Level",
                        style: kTitleTextstyle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: LightThemeColors.secounderyColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Center(
                            child: DropdownButton(
                                dropdownColor: LightThemeColors.secounderyColor,
                                alignment: Alignment.centerLeft,
                                value:
                                    controller.selectedLevelList.value.isEmpty
                                        ? null
                                        : controller.selectedLevelList.value,
                                style: TextStyle(color: Colors.white),
                                isExpanded: true,
                                underline: SizedBox(),
                                hint: const Text("Choose you Level"),
                                items: (controller.levelList.value)
                                    .map((mapValue) {
                                  return DropdownMenuItem(
                                    value: mapValue,
                                    child: Center(
                                        child: Text(mapValue.toString())),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  controller.selectedLevelList.value =
                                      newValue.toString();
                                  print(controller.selectedLevelList.value =
                                      newValue.toString());
                                }),
                          ),
                        ),
                      ),
                      divider,
                      //*********Price Text *************
                      Text(
                        "Price",
                        style: kTitleTextstyle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        height: size.height / 14,
                        width: size.width,
                        decoration: BoxDecoration(
                          color: LightThemeColors.secounderyColor,
                          borderRadius: BorderRadius.circular(10.0.r),
                        ),
                        child: Center(
                          child: CustomTextField(
                            fillColor: LightThemeColors.whiteColor,
                            hintText: "Price",
                            controller: controller.price.value,
                          ),
                        ),
                      ),
                      divider,
                      Column(
                        children: [
                          Row(
                            children: [
                              Text('Location',
                                  style: kTitleTextstyle.copyWith(
                                    fontWeight: FontWeight.w500,
                                  )),
                              gapWidth(size: 4.0.w),
                              Image.asset(
                                Img.locationIcon,
                                width: 16.r,
                                height: 16.r,
                              ),
                              gapWidth(size: 4.0.w),
                            ],
                          ),
                          gapHeight(size: 8.0.w),
                          // Obx(() {
                          //   // final location = homeC
                          //   //     .currentLocation.value;
                          //   final location =
                          //       customerHomeController.currentLocation.value;
                          //   return TextField(
                          //     readOnly: true,
                          //     decoration: InputDecoration(
                          //       filled: true,
                          //       fillColor: LightThemeColors.secounderyColor,
                          //       hintText: "Search Here",
                          //       prefixIcon: Icon(
                          //         Icons.search,
                          //         color: Colors.white,
                          //       ),
                          //       border: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(8),
                          //         borderSide: BorderSide(color: Colors.white),
                          //       ),
                          //       enabledBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(8),
                          //         borderSide: BorderSide(color: Colors.white),
                          //       ),
                          //       focusedBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(8),
                          //         borderSide: BorderSide(color: Colors.white),
                          //       ),
                          //       contentPadding: EdgeInsets.symmetric(
                          //           horizontal: 12, vertical: 14),
                          //     ),
                          //     controller: TextEditingController(
                          //         text: location?.fullAddress ?? "UAE, Dubai"),
                          //     onTap: () async {
                          //       controller.currentPosition = await controller
                          //           .locationService
                          //           .getCurrentLocation();
                          //       if (controller.currentPosition != null) {
                          //         await Get.toNamed(
                          //             Routes.CUSTOMER_PICK_LOCATION);
                          //         if (customerHomeController
                          //                 .currentLocation.value !=
                          //             null) {
                          //           // Here we get the values needed for API
                          //           final lat = customerHomeController
                          //               .currentLocation.value?.latitude
                          //               .toString();
                          //           final lng = customerHomeController
                          //               .currentLocation.value?.longitude
                          //               .toString();
                          //           final fullAddress = customerHomeController
                          //               .currentLocation.value?.fullAddress;
                          //
                          //           // Now you can use these values in your controller
                          //           controller.lat = lat;
                          //           controller.lng = lng;
                          //           controller.address.value.text =
                          //               fullAddress ?? "";
                          //         }
                          //       } else {
                          //         print("please_get_current_loaction");
                          //       }
                          //     },
                          //   );
                          // }),
                          Obx(() {
                            final location = controller.isCustomer.value
                                ? customerHomeController.currentLocation.value
                                : homeC.currentLocation.value;

                            return TextField(
                              readOnly: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: LightThemeColors.secounderyColor,
                                hintText: "Search Here",
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 14),
                              ),
                              controller: TextEditingController(
                                  text: location?.fullAddress ?? "UAE, Dubai"),
                              onTap: () async {
                                final userService = UserService();
                                bool? isCustomer = await userService.isUser();

                                controller.currentPosition = await controller
                                    .locationService
                                    .getCurrentLocation();
                                if (controller.currentPosition != null) {
                                  await Get.toNamed(
                                      Routes.CUSTOMER_PICK_LOCATION);

                                  if (isCustomer == true) {
                                    if (customerHomeController
                                            .currentLocation.value !=
                                        null) {
                                      controller.lat = customerHomeController
                                          .currentLocation.value?.latitude
                                          .toString();
                                      controller.lng = customerHomeController
                                          .currentLocation.value?.longitude
                                          .toString();
                                      controller.address.value.text =
                                          customerHomeController.currentLocation
                                                  .value?.fullAddress ??
                                              "";
                                    }
                                  } else {
                                    if (homeC.currentLocation.value != null) {
                                      controller.lat = homeC
                                          .currentLocation.value?.latitude
                                          .toString();
                                      controller.lng = homeC
                                          .currentLocation.value?.longitude
                                          .toString();
                                      controller.address.value.text = homeC
                                              .currentLocation
                                              .value
                                              ?.fullAddress ??
                                          "";
                                    }
                                  }
                                } else {
                                  print("please_get_current_location");
                                }
                              },
                            );
                          })
                        ],
                      ),
                      divider,
                      Obx(() => CustomButton(
                            bgColor: LightThemeColors.primaryColor,
                            ontap: controller.isLoading.value
                                ? () {} // Empty callback instead of null
                                : () {
                                    controller.customerCreateAuction(
                                      controller.categooryId ?? 0,
                                      controller.selectedSubCategoryId.value,
                                      controller.selectedCurrency.value,
                                      controller.selectedPriceType.value,
                                      controller.selectedLevelList.value,
                                    );
                                  },
                            widget: controller.isLoading.value
                                ? SizedBox(
                                    height: 20.r,
                                    width: 20.r,
                                    child: CircularProgressIndicator(
                                      color: LightThemeColors.whiteColor,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    "Create",
                                    style: kTitleTextstyle,
                                  ),
                          )),
                      divider,
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
