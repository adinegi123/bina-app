import 'package:shared_preferences/shared_preferences.dart';

class ApiConstants {
  static String baseUrl = 'https://binaadmin.witvisitor.in/index.php/api';
  static String bannersEndpoint = '/bannerFetchdata';
  static String categoryEndpoint = '/get_category';
  static String registerEndPoint = '/signup';
  static String loginEndPoint = '/login';
  static String registerEndpointUser = '/user_registration';
  static String registerEndpointCompany = '/company_registration';
  static String loginEndPointUserCompany = '/user_company_login';
  static late SharedPreferences prefs;
  static String imageUrl = 'https://binaadmin.witvisitor.in/';
  static String updateandSaveUserProfile = '/UserProfileUpdate';
  static String sendNewPasswordEndPoint = "/sendNewPassword";
  static String stateNameEndpoint = "/getCityName";
  static String subCategoryEndPoint = "/get_sub_category";
  static String deleteAccountEndPoint = "/delAccount";
  static String totalVaccancyEndPoint = "/totalVacancy";
  static String VaccancyListEndPoint = "/getVacancy";
  static String JobListTypeEndPoint = "/job_type_list";
  static String PostVaccancyEndPoint = "/save_vacancy";
  static String AppliedCandidatesListEndPoint = "/appliedCandidatesList";
  static String CountAppliedCandidatesEndPoint = "/countAppliedCandidates";
  static String applyForJobEndPoint = "/lookingVacancy";
  static String candidateDetailsEndPoint = "/appliedCandidatesDetails";
  static String appliedJobSaveEndPoint = "/appiliedJobSave";
  static String addBidEndPoint = "/add_bid";
  static String addOfferEndPoint = "/addOffer";
  static String getBidListEndPoint = "/getBidList";
  static String getBidDetailsEndPoint = "/getBidUserDetails";
  static String filterApiEndPoint = "/get_category_sub_category_list";
  static String getNotificationListEndpoint = "/getNotification";
  static String inAppNotificationEndpoint = "/inapp_notification";
  static String PostSaveUserRating = "/saveRating";
  static String vaccancyDetails = "/vacancyDetails";
  static String getRatingEndpoint = "/ratingList";
  static String vacanciesPosted = "/vacancies_posted";
  static String vaccancycandidateList = "/vacancyAppliedCandidates";
}

///APIs class is for api tags
// class Apis {
//   static const String registerEndPoint = '/signup';
// }
// @RestApi(baseUrl: "http://binaadmin.witvisitor.in/index.php/api")
// abstract class ApiClient {
//   factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;
//
//   @POST(Apis.registerEndPoint)
//   Future<RegisterModel> signup(
//       @Query("name") String name,
//       @Query("email") String email,
//       @Query("password") String password,
//       @Query("dob") String dob,
//       @Query("sex") String sex,
//       @Query("mobile") String mobile,
//       @Query("category_id") String category_id,
//       @Query("category_name") String category_name,
//       @Query("sub_category_id") String sub_category_id,
//       @Query("sub_category_name") String sub_category_name,
//       @Query("address") String address,
//       @Query("lat") String lat,
//       @Query("lon") String lon,
//       @Query("signup_as") String signup_as,
//       @Query("register_id") String register_id);
// }
