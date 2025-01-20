import 'package:dirham_uae/app/components/custom_appBar.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../components/custom_button.dart';
import '../controllers/account_details_controller.dart';

class CustomerAccountDetailsView
    extends GetView<CustomerAccountDetailsController> {
  const CustomerAccountDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isCustomerInfoloading.value
            ? const Center(child: CircularProgressIndicator())
            : _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final customerInfo = controller.customerInfo.value;
    print('===============');
    print(customerInfo.toString());
    print('===============');

    if (customerInfo == null) {
      return const Center(child: Text('No data available'));
    }

    return Container(
      padding: EdgeInsets.only(
        top: 0,
        left: 15.r,
        right: 15.r,
      ),
      decoration: BoxDecoration(gradient: buildCustomGradient()),
      child: Column(
        children: [
          CustomHeaderBar(title: 'Account Details'),

          gapHeight(size: 20),

          // Profile Image

          // CircleAvatar(
          //   radius: 60.r,
          //   backgroundImage: customerInfo.profile?.image != null
          //       ? NetworkImage(customerInfo.profile!.image!)
          //       : const AssetImage('assets/images/profile.jpg'),
          // ),
          CircleAvatar(
            radius: 60.r,
            backgroundImage: customerInfo.profile?.image != null
                ? NetworkImage(customerInfo.profile!.image!) as ImageProvider
                : const AssetImage('assets/images/profile.jpg')
                    as ImageProvider,
            onBackgroundImageError: (e, stackTrace) {
              print('Error loading image: $e');
              // Fallback to asset image
            },
          ),
          gapHeight(size: 30),

          // User Details
          AccountDetailsCard(
            title: "Full Name:",
            subtitle:
                "${customerInfo.name ?? 'N/A'} ${customerInfo.profile?.lastName ?? ''}",
          ),

          gapHeight(size: 20),

          AccountDetailsCard(
            title: "Email:",
            subtitle: customerInfo.email ?? 'N/A',
          ),

          gapHeight(size: 20),

          AccountDetailsCard(
            title: "Phone:",
            subtitle: customerInfo.mobile ?? 'N/A',
          ),

          gapHeight(size: 20),

          // Additional Profile Information
          if (customerInfo.profile != null) ...[
            AccountDetailsCard(
              title: "Country:",
              subtitle: customerInfo.profile?.country ?? 'N/A',
            ),
            gapHeight(size: 20),
            AccountDetailsCard(
              title: "Location:",
              subtitle: customerInfo.profile?.location ?? 'N/A',
            ),
            gapHeight(size: 20),
            AccountDetailsCard(
              title: "Bio:",
              subtitle: customerInfo.profile?.bio ?? 'No bio available',
            ),
          ],

          const Spacer(),

          CustomButton(
            bgColor: LightThemeColors.primaryColor,
            ontap: () {
              Get.toNamed(Routes.CUSTOMER_UPDATE_DETAILS);
            },
            widget: Text(
              "Update Information",
              style: kTitleTextstyle,
            ),
          ),

          gapHeight(size: 20)
        ],
      ),
    );
  }
}

// Improved AccountDetailsCard with better text overflow handling
class AccountDetailsCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const AccountDetailsCard({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                title,
                style: kSubtitleStyle,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                subtitle,
                style: kTitleTextstyle,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            )
          ],
        ),
        Divider(color: LightThemeColors.dividerColor)
      ],
    );
  }
}
