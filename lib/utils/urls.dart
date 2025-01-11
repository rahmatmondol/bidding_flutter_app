class Constants {
  static const baseUrl = 'https://dirham365.com/api';
  static const getCustomerInfo = "$baseUrl/auth/get-user-info";

  static const customerSignUpUrl = "$baseUrl/auth/register";
  static const customerLoginUrl = "$baseUrl/auth/login";
  static const customerChnagePasswordUrl = "$baseUrl/auth/change-password";

  // static const customerlogOutUrl = "$baseUrl/logout";
  static const customerInfoUpdateUrl = "$baseUrl/auth/update-profile";

  static const getCategogy = "$baseUrl/get-categories";

  // static const getSubCategory = "$baseUrl/get-subcategories";
  static const getServiceCustomer = "$baseUrl/get-services";

  // static String ServiceCustomerDetails = '$baseUrl/get-service';

  static String ServiceCustomerDetails(int id) => '$baseUrl/get-service/$id';
  static const customerCreateService = "$baseUrl/auth/create-service";

  static custommerBettingList(int id) =>
      '$baseUrl/auth/get-biddings?service_id=$id';
  static const custommerBettingListDetails =
      baseUrl + "api/v1/provider_details";
  static const acceptBooking = baseUrl + "api/v1/betting-accept";
  static const String google_api_key =
      "AIzaSyCc9NIB-ScnkTvQZzrB53TfaCwo1XUegHM";

  static String getSubCategoryByID(int categoryId) =>
      '$baseUrl/get-subcategories?category_id=$categoryId';

  // *************Provider**************
  static const providerSignUpUrl = "$baseUrl/auth/register";
  static const providerLoginUpUrl = "$baseUrl/auth/login";
  static const providerLogOutUpUrl = baseUrl + "api/v1/auth/provider/logout";
  static const providerChnagePasswordUrl = "$baseUrl/auth/change-password";
  static const providerInfoUpdateUrl = "$baseUrl/auth/update-profile";
  static const getProviderInfo = baseUrl + "api/v1/auth/provider";
  static const getZoneId = "$baseUrl/get-categories";
  static const getAllServiceUrl = "$baseUrl/get-services";
  static const getCategoriesUrl = "$baseUrl/get-categories";
  static const createBidding = "$baseUrl/auth/create-bidding";
}
