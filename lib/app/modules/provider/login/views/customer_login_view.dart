import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dirham_uae/app/components/custom_text_field.dart';
import 'package:dirham_uae/app/modules/provider/login/controllers/login_controller.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import '../../../../../config/theme/light_theme_colors.dart';
import '../../../../../config/theme/my_images.dart';
import '../../../../../config/theme/my_styles.dart';
import '../../../../../utils/global_variable/divider.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_pass_text_field.dart';

class CustomerLoginView extends StatelessWidget {
  const CustomerLoginView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            divider,
            //*********TextField******** */
            Text(
              "Email",
              style: kSubtitleStyle,
            ),
            CustomTextField(
              fillColor: Colors.white,
              icon: Img.messageIcon,
              isSuffixIcon: true,
              isIcon: true,
              hintText: "email",
              controller: loginController.customerEmailController,
              prefixIconScale: 3,
            ),
            gapHeight(size: 10.0.h),
            //********* Password TextField*********/
            Text(
              "Password",
              style: kSubtitleStyle,
            ),
            CustomPasswordTextField(
              
              hintText: "password",
              controller: loginController.customerPassController,
            ),
            divider,
            //***********Forget password**********
            InkWell(
              onTap: () => Get.toNamed(Routes.CUSTOMER_RESET),
              child: Text(
                "Forgot password ?",
                style: kTitleTextstyle.copyWith(
                    color: LightThemeColors.primaryColor),
              ),
            ),
            divider,
            divider,
            CustomButton(
              bgColor: LightThemeColors.primaryColor,
              ontap: () {
                loginController.CustomerLoginUser(context);
              },
              widget: Text(
                "Login",
                style: kTitleTextstyle,
              ),
            ),
            // ************OR***************
            divider,

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color: LightThemeColors.whiteColor,
                      thickness: 1.5,
                    ),
                  ),
                  gapWidth(size: 10.0.w),
                  Text("Or"),
                  gapWidth(size: 10.0.w),
                  Expanded(
                    child: Divider(
                      color: LightThemeColors.whiteColor,
                      thickness: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            divider,
            //*************Google*************** */
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.r, horizontal: 20),
                decoration: BoxDecoration(
                  color: LightThemeColors.secounderyColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Img.googleIcon,
                          scale: 3.5,
                        ),
                        gapWidth(size: 5.0.w),
                        Text("Google"),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
