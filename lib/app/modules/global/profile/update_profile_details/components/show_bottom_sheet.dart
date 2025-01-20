import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:dirham_uae/utils/global_variable/divider.dart';

Future<void> showMyBottomSheet({
  required BuildContext context,
  required  controller,
}) async =>
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        //  EditProfileController controller = Get.put(EditProfileController());
        final size = MediaQuery.sizeOf(context);
        return Container(
          height: size.height * 0.20,
          decoration: BoxDecoration(
            color: LightThemeColors.scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w),
            child: Column(
              children: [
                gapHeight(size: 20),
                CustomButton(
                  bgColor: LightThemeColors.primaryColor.withOpacity(.9),
                  ontap: () {
                    controller.pickImage(ImageSource.gallery, context);
                  },
                  widget: Text("Gallery"),
                ),
                divider,
                CustomButton(
                  bgColor: LightThemeColors.primaryColor.withOpacity(.9),
                  ontap: () {
                    controller.pickImage(ImageSource.camera, context);
                  },
                  widget: Text("Camera"),
                ),
              ],
            ),
          ),
        );
      },
    );



