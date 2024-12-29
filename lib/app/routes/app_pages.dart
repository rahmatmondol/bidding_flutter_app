import 'package:get/get.dart';

import '../modules/change_password/bindings/change_password_binding.dart';
import '../modules/change_password/views/change_password_view.dart';
import '../modules/customer/customer_about_us/bindings/customer_about_us_binding.dart';
import '../modules/customer/customer_about_us/views/customer_about_us_view.dart';
import '../modules/customer/customer_account_details/bindings/customer_account_details_binding.dart';
import '../modules/customer/customer_account_details/views/customer_account_details_view.dart';
import '../modules/customer/customer_add_service/bindings/customer_add_service_binding.dart';
import '../modules/customer/customer_add_service/views/customer_add_service_view.dart';
import '../modules/customer/customer_booking/bindings/customer_booking_binding.dart';
import '../modules/customer/customer_booking/views/customer_booking_view.dart';
import '../modules/customer/customer_change_password/bindings/customer_change_password_binding.dart';
import '../modules/customer/customer_change_password/views/customer_change_password_view.dart';
import '../modules/customer/customer_chat/bindings/customer_chat_binding.dart';
import '../modules/customer/customer_chat/views/customer_chat_view.dart';
import '../modules/customer/customer_create_password/bindings/customer_create_password_binding.dart';
import '../modules/customer/customer_create_password/views/customer_create_password_view.dart';
import '../modules/customer/customer_home/bindings/customer_home_binding.dart';
import '../modules/customer/customer_home/views/customer_home_view.dart';
import '../modules/customer/customer_inbox/bindings/customer_inbox_binding.dart';
import '../modules/customer/customer_inbox/views/customer_inbox_view.dart';
import '../modules/customer/customer_language/bindings/customer_language_binding.dart';
import '../modules/customer/customer_language/views/customer_language_view.dart';
import '../modules/customer/customer_location/bindings/customer_location_binding.dart';
import '../modules/customer/customer_location/views/customer_location_view.dart';
import '../modules/customer/customer_notification/bindings/customer_notification_binding.dart';
import '../modules/customer/customer_notification/views/customer_notification_view.dart';
import '../modules/customer/customer_otp/bindings/customer_otp_binding.dart';
import '../modules/customer/customer_otp/views/customer_otp_view.dart';
import '../modules/customer/customer_payment/bindings/customer_payment_binding.dart';
import '../modules/customer/customer_payment/views/customer_payment_view.dart';
import '../modules/customer/customer_privacy_and_policy/bindings/customer_privacy_and_policy_binding.dart';
import '../modules/customer/customer_privacy_and_policy/views/customer_privacy_and_policy_view.dart';
import '../modules/customer/customer_profile/bindings/customer_profile_binding.dart';
import '../modules/customer/customer_profile/views/customer_profile_view.dart';
import '../modules/customer/customer_reset/bindings/customer_reset_binding.dart';
import '../modules/customer/customer_reset/views/customer_reset_view.dart';
import '../modules/customer/customer_search/bindings/customer_search_binding.dart';
import '../modules/customer/customer_search/views/customer_search_view.dart';
import '../modules/customer/customer_tab/bindings/customertab_binding.dart';
import '../modules/customer/customer_tab/views/customertab_view.dart';
import '../modules/customer/customer_terms_and_condition/bindings/customer_terms_and_condition_binding.dart';
import '../modules/customer/customer_terms_and_condition/views/customer_terms_and_condition_view.dart';
import '../modules/customer/customer_update_details/bindings/customer_update_details_binding.dart';
import '../modules/customer/customer_update_details/views/customer_update_details_view.dart';
import '../modules/global/intro_one/bindings/intro_one_binding.dart';
import '../modules/global/intro_one/views/intro_one_view.dart';
import '../modules/global/login_signup/bindings/login_signup_binding.dart';
import '../modules/global/login_signup/views/login_signup_view.dart';
import '../modules/global/splash/bindings/splash_binding.dart';
import '../modules/global/splash/views/splash_view.dart';
import '../modules/provider/about_us/bindings/about_us_binding.dart';
import '../modules/provider/about_us/views/about_us_view.dart';
import '../modules/provider/account_details/bindings/account_details_binding.dart';
import '../modules/provider/account_details/views/account_details_view.dart';
import '../modules/provider/account_update_details/bindings/account_update_details_binding.dart';
import '../modules/provider/account_update_details/views/account_update_details_view.dart';
import '../modules/provider/all_category/bindings/all_category_binding.dart';
import '../modules/provider/all_category/views/all_category_view.dart';
import '../modules/provider/all_subCategory/bindings/all_sub_category_binding.dart';
import '../modules/provider/all_subCategory/views/all_sub_category_view.dart';
import '../modules/provider/apply/bindings/apply_binding.dart';
import '../modules/provider/apply/views/apply_view.dart';
import '../modules/provider/booking/bindings/booking_binding.dart';
import '../modules/provider/booking/views/booking_view.dart';
import '../modules/provider/chat/bindings/chat_binding.dart';
import '../modules/provider/chat/views/chat_view.dart';
import '../modules/provider/create_password/bindings/create_password_binding.dart';
import '../modules/provider/create_password/views/create_password_view.dart';
import '../modules/provider/favorite_service/bindings/favorite_service_binding.dart';
import '../modules/provider/favorite_service/views/favorite_service_view.dart';
import '../modules/provider/home/bindings/home_binding.dart';
import '../modules/provider/home/views/home_view.dart';
import '../modules/provider/inbox/bindings/inbox_binding.dart';
import '../modules/provider/inbox/views/inbox_view.dart';
import '../modules/provider/language/bindings/language_binding.dart';
import '../modules/provider/language/views/language_view.dart';
import '../modules/provider/login/bindings/login_binding.dart';
import '../modules/provider/login/views/login_view.dart';
import '../modules/provider/nav_bar/bindings/nav_bar_binding.dart';
import '../modules/provider/nav_bar/views/nav_bar_view.dart';
import '../modules/provider/notification/bindings/notification_binding.dart';
import '../modules/provider/notification/views/notification_view.dart';
import '../modules/provider/otp/bindings/otp_binding.dart';
import '../modules/provider/otp/views/otp_view.dart';
import '../modules/provider/privacy_and_policy/bindings/privacy_and_policy_binding.dart';
import '../modules/provider/privacy_and_policy/views/privacy_and_policy_view.dart';
import '../modules/provider/profile/bindings/profile_binding.dart';
import '../modules/provider/profile/views/profile_view.dart';
import '../modules/provider/proposals/bindings/proposals_binding.dart';
import '../modules/provider/proposals/views/proposals_view.dart';
import '../modules/provider/provider_tab/bindings/provider_tab_binding.dart';
import '../modules/provider/provider_tab/views/provider_tab_view.dart';
import '../modules/provider/reset_password/bindings/reset_password_binding.dart';
import '../modules/provider/reset_password/views/reset_password_view.dart';
import '../modules/provider/review/bindings/review_binding.dart';
import '../modules/provider/review/views/review_view.dart';
import '../modules/provider/search/bindings/search_binding.dart';
import '../modules/provider/search/views/search_view.dart';
import '../modules/provider/signup/bindings/signup_binding.dart';
import '../modules/provider/signup/views/signup_view.dart';
import '../modules/provider/terms_and_condition/bindings/terms_and_condition_binding.dart';
import '../modules/provider/terms_and_condition/views/terms_and_condition_view.dart';
import '../modules/provider/thanks/bindings/thanks_binding.dart';
import '../modules/provider/thanks/views/thanks_view.dart';
import '../modules/services/bindings/services_binding.dart';
import '../modules/services/views/services_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.INTRO_ONE,
      page: () => const IntroOneView(),
      binding: IntroOneBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_SIGNUP,
      page: () => const LoginSignupView(),
      binding: LoginSignupBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.NAV_BAR,
      page: () => const NavBarView(),
      binding: NavBarBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMERTAB,
      page: () => const CustomertabView(),
      binding: CustomertabBinding(),
    ),
    GetPage(
      name: _Paths.PROVIDER_TAB,
      page: () => const ProviderTabView(),
      binding: ProviderTabBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_PASSWORD,
      page: () => const CreatePasswordView(),
      binding: CreatePasswordBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    // GetPage(
    //   name: _Paths.DESCRIPTION,
    //   page: () => const DescriptionView(),
    //   binding: DescriptionBinding(),
    // ),
    GetPage(
      name: _Paths.APPLY,
      page: () => const ApplyView(),
      binding: ApplyBinding(),
      children: [
        GetPage(
          name: _Paths.APPLY,
          page: () => const ApplyView(),
          binding: ApplyBinding(),
        ),
      ],
    ),
    // GetPage(
    //   name: _Paths.LOCATION,
    //   page: () => const LocationView(),
    //   binding: LocationBinding(),
    // ),
    // GetPage(
    //   name: _Paths.PICK_LOCATION,
    //   page: () => const PickLocationView(),
    //   binding: PickLocationBinding(),
    // ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.ALL_CATEGORY,
      page: () => const AllCategoryView(),
      binding: AllCategoryBinding(),
    ),
    GetPage(
      name: _Paths.ALL_SUB_CATEGORY,
      page: () => const AllSubCategoryView(),
      binding: AllSubCategoryBinding(),
    ),

    GetPage(
      name: _Paths.BOOKING,
      page: () => const BookingView(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_ACCOUNT_DETAILS,
      page: () => const CustomerAccountDetailsView(),
      binding: CustomerAccountDetailsBinding(),
    ),
    GetPage(
      name: _Paths.LANGUAGE,
      page: () => const LanguageView(),
      binding: LanguageBinding(),
    ),
    GetPage(
      name: _Paths.PROPOSALS,
      page: () => const ProposalsView(),
      binding: ProposalsBinding(),
    ),
    GetPage(
      name: _Paths.TERMS_AND_CONDITION,
      page: () => const TermsAndConditionView(),
      binding: TermsAndConditionBinding(),
    ),
    GetPage(
      name: _Paths.PRIVACY_AND_POLICY,
      page: () => const PrivacyAndPolicyView(),
      binding: PrivacyAndPolicyBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT_US,
      page: () => const AboutUsView(),
      binding: AboutUsBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITE_SERVICE,
      page: () => const FavoriteServiceView(),
      binding: FavoriteServiceBinding(),
    ),
    GetPage(
      name: _Paths.INBOX,
      page: () => const InboxView(),
      binding: InboxBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_UPDATE_DETAILS,
      page: () => const CustomerUpdateDetailsView(),
      binding: CustomerUpdateDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_CHANGE_PASSWORD,
      page: () => const CustomerChangePasswordView(),
      binding: CustomerChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.THANKS,
      page: () => const ThanksView(),
      binding: ThanksBinding(),
    ),
    GetPage(
      name: _Paths.REVIEW,
      page: () => const ReviewView(),
      binding: ReviewBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_HOME,
      page: () => CustomerHomeView(),
      binding: CustomerHomeBinding(),
    ),
    // GetPage(
    //   name: _Paths.CUSTOMER_NAV_BAR,
    //   page: () => const CustomerNavBarView(),
    //   binding: CustomerNavBarBinding(),
    // ),
    GetPage(
      name: _Paths.CUSTOMER_BOOKING,
      page: () => const CustomerBookingView(),
      binding: CustomerBookingBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_INBOX,
      page: () => const CustomerInboxView(),
      binding: CustomerInboxBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_CHAT,
      page: () => const CustomerChatView(),
      binding: CustomerChatBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_NOTIFICATION,
      page: () => const CustomerNotificationView(),
      binding: CustomerNotificationBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_PROFILE,
      page: () => const CustomerProfileView(),
      binding: CustomerProfileBinding(),
    ),
    // GetPage(
    //   name: _Paths.CUSTOMER_SERVICE_DETAILS,
    //   page: () => const CustomerServiceDetailsView(),
    //   binding: CustomerServiceDetailsBinding(),
    // ),
    // GetPage(
    //   name: _Paths.CUSTOMER_WORK_PEOPLE_LIST,
    //   page: () => const CustomerWorkPeopleListView(),
    //   binding: CustomerWorkPeopleListBinding(),
    // ),
    // GetPage(
    //   name: _Paths.CUSTOMER_WORK_PEOPLE_DETAILS,
    //   page: () => const CustomerWorkPeopleDetailsView(),
    //   binding: CustomerWorkPeopleDetailsBinding(),
    // ),
    GetPage(
      name: _Paths.CUSTOMER_ADD_SERVICE,
      page: () => CustomerAddServiceView(),
      binding: CustomerAddServiceBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_PAYMENT,
      page: () => const CustomerPaymentView(),
      binding: CustomerPaymentBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_RESET,
      page: () => const CustomerResetView(),
      binding: CustomerResetBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_CREATE_PASSWORD,
      page: () => const CustomerCreatePasswordView(),
      binding: CustomerCreatePasswordBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_OTP,
      page: () => const CustomerOtpView(),
      binding: CustomerOtpBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_LOCATION,
      page: () => const CustomerLocationView(),
      binding: CustomerLocationBinding(),
    ),
    // GetPage(
    //   name: _Paths.CUSTOMER_PICK_LOCATION,
    //   page: () => const CustomerPickLocationView(),
    //   binding: CustomerPickLocationBinding(),
    // ),
    GetPage(
      name: _Paths.CUSTOMER_SEARCH,
      page: () => const CustomerSearchView(),
      binding: CustomerSearchBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_LANGUAGE,
      page: () => const CustomerLanguageView(),
      binding: CustomerLanguageBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_ABOUT_US,
      page: () => const CustomerAboutUsView(),
      binding: CustomerAboutUsBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_TERMS_AND_CONDITION,
      page: () => const CustomerTermsAndConditionView(),
      binding: CustomerTermsAndConditionBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_PRIVACY_AND_POLICY,
      page: () => const CustomerPrivacyAndPolicyView(),
      binding: CustomerPrivacyAndPolicyBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_DETAILS,
      page: () => const AccountDetailsView(),
      binding: AccountDetailsBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_UPDATE_DETAILS,
      page: () => const AccountUpdateDetailsView(),
      binding: AccountUpdateDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.SERVICES,
      page: () => const ServicesView(),
      binding: ServicesBinding(),
    ),
  ];
}
