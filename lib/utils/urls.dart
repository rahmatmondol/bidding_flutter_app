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

  static String ServiceCustomerDetails(int id) => '$baseUrl/get-service/$id';

  static String updatePostStatus(int id) => '$baseUrl/auth/update-booking/$id';
  static const customerCreateService = "$baseUrl/auth/create-service";

  static custommerBeddingList(int id) =>
      '$baseUrl/auth/get-biddings?service_id=$id';

  // static const custommerBettingListDetails = '$baseUrl/auth/get-bidding-info';

  static custommerBettingListDetails(int id) =>
      '$baseUrl/auth/get-bidding-info?bid_id=$id';

  static const acceptBooking = "$baseUrl/auth/create-booking";

  static String getSubCategoryByID(int categoryId) =>
      '$baseUrl/get-subcategories?category_id=$categoryId';

  static const getBookings = "$baseUrl/auth/get-bookings";
  static const createReview = "$baseUrl/auth/create-review";

  // *************Provider**************
  static const providerSignUpUrl = "$baseUrl/auth/register";
  static const providerLoginUpUrl = "$baseUrl/auth/login";
  static const providerLogOutUpUrl = baseUrl + "api/v1/auth/provider/logout";
  static const providerChnagePasswordUrl = "$baseUrl/auth/change-password";
  static const providerInfoUpdateUrl = "$baseUrl/auth/update-profile";
  static const getProviderInfo = "$baseUrl/auth/get-user-info";
  static const getZoneId = "$baseUrl/get-categories";
  static const getAllServiceUrl = "$baseUrl/get-services";
  static const getCategoriesUrl = "$baseUrl/get-categories";
  static const createBidding = "$baseUrl/auth/create-bidding";
  static const getBidding = "$baseUrl/auth/get-biddings";
  static const createWishList = "$baseUrl/auth/create-wishlist";
  static const getWishList = "$baseUrl/auth/get-wishlists";

  static deleteWishList(id) => "$baseUrl/auth/delete-wishlist/$id";

  static const String google_api_key =
      "AIzaSyCc9NIB-ScnkTvQZzrB53TfaCwo1XUegHM";
}
