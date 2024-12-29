class Constants {
  static const baseUrl = 'https://dirham365.com/';
  static const getCustomerInfo = baseUrl + "api/v1/customer";
  static const getCategogy = baseUrl + "api/v1/categories";
  static const getServiceCustomer = baseUrl + "api/v1/customer/service/get";
  static const ServiceCustomerDetails = baseUrl + "api/v1/customer/service/details";

  static const customerSignUpUrl = baseUrl + "api/auth/register";
  static const customerLoginUrl = baseUrl + "api/v1/customer/auth/login";
  static const customerChnagePasswordUrl =
      baseUrl + "api/v1/customer/change-password";
  static const customerlogOutUrl = baseUrl + "api/v1/customer/logout";
  static const customerInfoUpdateUrl = baseUrl + "api/v1/customer/update";
  static const customerCreateService = baseUrl + "api/v1/customer/service/add";
  static const custommerBettingList = baseUrl + "api/v1/betting_list";
  static const custommerBettingListDetails = baseUrl + "api/v1/provider_details";
  static const acceptBooking = baseUrl + "api/v1/betting-accept";
  static const String google_api_key =
      "AIzaSyCc9NIB-ScnkTvQZzrB53TfaCwo1XUegHM";

  // *************Provider**************
  static const providerSignUpUrl = baseUrl + "api/v1/auth/provider/register";
  static const providerLoginUpUrl = baseUrl + "api/v1/auth/provider/login";
  static const providerLogOutUpUrl = baseUrl + "api/v1/auth/provider/logout";
  static const providerChnagePasswordUrl =
      baseUrl + "api/v1/auth/provider/update-password";
  static const providerInfoUpdateUrl = baseUrl + "api/v1/auth/provider/update";
  static const getProviderInfo = baseUrl + "api/v1/auth/provider";
  static const getZoneId = baseUrl + "api/get-categories";
  static const getServiceUrl = baseUrl + "api/v1/provider/get-service";
  static const getCategoriesUrl = baseUrl + "api/v1/categories";
}
