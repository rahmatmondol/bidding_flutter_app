class Constants {
  static const baseUrl = 'https://dirham365.com/api';
  static const getCustomerInfo = "$baseUrl/auth/get-user-info";

  static const customerSignUpUrl = "$baseUrl/auth/register";
  static const customerLoginUrl = "$baseUrl/auth/login";
  static const customerChnagePasswordUrl = "$baseUrl/auth/change-password";
  static const customerlogOutUrl = "$baseUrl/logout";
  static const customerInfoUpdateUrl = "$baseUrl/auth/update-profile";

  static const getCategogy = "$baseUrl/get-categories";
  static const getServiceCustomer = "$baseUrl/auth/create-service";
  static const ServiceCustomerDetails =
      baseUrl + "api/v1/customer/service/details";
  static const customerCreateService = "$baseUrl/auth/create-service";
  static const custommerBettingList = baseUrl + "api/v1/betting_list";
  static const custommerBettingListDetails =
      baseUrl + "api/v1/provider_details";
  static const acceptBooking = baseUrl + "api/v1/betting-accept";
  static const String google_api_key =
      "AIzaSyCc9NIB-ScnkTvQZzrB53TfaCwo1XUegHM";

  // *************Provider**************
  static const providerSignUpUrl = "$baseUrl/auth/register";
  static const providerLoginUpUrl = "$baseUrl/auth/login";
  static const providerLogOutUpUrl = baseUrl + "api/v1/auth/provider/logout";
  static const providerChnagePasswordUrl = "$baseUrl/auth/change-password";
  static const providerInfoUpdateUrl = "$baseUrl/auth/update-profile";
  static const getProviderInfo = baseUrl + "api/v1/auth/provider";
  static const getZoneId = "$baseUrl/get-categories";
  static const getServiceUrl = "$baseUrl/get-service/5";
  static const getCategoriesUrl = "$baseUrl/get-categories";
}
