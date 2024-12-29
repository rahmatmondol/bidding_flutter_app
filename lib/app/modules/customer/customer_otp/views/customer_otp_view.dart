import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/utils/global_variable/my_scaffold_background.dart';
import '../../../../../config/theme/my_styles.dart';
import '../../../../../utils/global_variable/divider.dart';
import '../controllers/customer_otp_controller.dart';

class CustomerOtpView extends GetView<CustomerOtpController> {
  const CustomerOtpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: MyScaffoldBackground(
        size: size,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                divider,
                //********Titile is here******/
                Text(
                  "One time password",
                  style: kHeadingTextStyle,
                ),
                gapHeight(size: 5.0.h),
                Text(
                  "Enter theOTP associated with your account and\nwe'll send an SMS with instructions to reset your password.",
                  style: kSubtitleStyle,
                ),
                divider,
                Image.asset(Img.otpImg),

                //********Titile is here***** */
                Center(
                  child: Text(
                    "Check  Your Email",
                    style: kHeadingTextStyle,
                  ),
                ),
                gapHeight(size: 5.0.h),
                Center(
                  child: Text(
                    "Enter the verification code sent to \n ABC123@gmail.com ",
                    textAlign: TextAlign.center,
                    style: kSubtitleStyle,
                  ),
                ),
                divider,
                Center(
                  child: Pinput(
                    length: 4,
                    defaultPinTheme: defaultPinTheme,
                    cursor: cursor,
                    preFilledWidget: preFilledWidget,

                    // focusedPinTheme: selectOTPTheme,
                    // validator: (pin) {
                    //   return pin == '222222' ? null : 'OTP is incorrect';
                    // },
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    onCompleted: (pin) => print(pin),
                    onChanged: (value) {
                      controller.code.value = value;
                    },
                  ),
                ),
                //********Titile is here***** */
                divider,
                Center(
                  child: Text(
                    "Don’t Receive the OTP ?",
                    style: kHeadingTextStyle,
                  ),
                ),
                gapHeight(size: 5.0.h),
                Center(
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      "Resend Code ",
                      textAlign: TextAlign.center,
                      style: kSubtitleStyle,
                    ),
                  ),
                ),
                Spacer(),
                CustomButton(
                  bgColor: LightThemeColors.primaryColor,
                  //ontap: () => Get.toNamed(Routes.CUSTOMER_NAV_BAR),
                  ontap: () {},
                  widget: Text("Verify"),
                ),
                divider,
                divider,
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: kTitleTextstyle.copyWith(
    fontSize: 22,
    color: Color.fromARGB(255, 255, 255, 255),
  ),
  decoration: const BoxDecoration(),
);
const Color borderColor = LightThemeColors.primaryColor;

final cursor = Column(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    Container(
      width: 56,
      height: 3,
      decoration: BoxDecoration(
        color: borderColor,
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ],
);

final preFilledWidget = Column(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    Container(
      width: 56,
      height: 3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ],
);
