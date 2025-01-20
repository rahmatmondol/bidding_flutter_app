import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:dirham_uae/utils/global_variable/my_scaffold_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../utils/global_variable/divider.dart';
import '../../../../components/loading_overley.dart';
import '../controllers/login_controller.dart';
import 'customer_login_view.dart';
import 'provider_login_view.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());
    Size size = MediaQuery.sizeOf(context);
    return Obx(
      () => LoadingOverlay(
        isLoading: controller.isLoading.value ||
            controller.isProviderLoginLoading.value,
        loadingMessage: 'Checking',
        child: Scaffold(
          body: DefaultTabController(
            length: 2,
            child: MyScaffoldBackground(
              size: size,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 15.0.w, right: 15.0.w, top: 20.0.h, bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //********Titile is here***** */
                      Text(
                        "Hi, Welcome Back!",
                        style: kHeadingTextStyle,
                      ),
                      Text(
                        "Sing in to your Account",
                        style: kSubtitleStyle,
                      ),
                      divider,

                      // *********Images*************
                      Container(
                        //color: Colors.red,
                        child: Center(
                          child: Image.asset(
                            Img.loginImages,
                            scale: 4,
                          ),
                        ),
                      ),
                      divider,
                      TabBar(
                          labelStyle: kTitleTextstyle.copyWith(
                              fontWeight: FontWeight.bold),
                          unselectedLabelStyle: kTitleTextstyle,
                          unselectedLabelColor:
                              LightThemeColors.secounderyTextColor,
                          indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(
                                width: 2.r,
                                color: LightThemeColors.primaryColor,
                              ),
                              insets: EdgeInsets.symmetric(horizontal: 40.r)),
                          labelColor: LightThemeColors.primaryColor,

                          //indicatorColor: Colors.white,
                          indicatorWeight: 15.w,
                          tabs: [
                            Text("Customer"),
                            Text("Provider"),
                          ]),
                      //***************Tabbar view****************** */
                      Expanded(
                        child: TabBarView(
                          children: [
                            CustomerLoginView(),
                            ProviderLoginView(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
