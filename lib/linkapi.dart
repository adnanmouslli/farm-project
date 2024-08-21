class AppLink {

  // static const String server = "http://10.0.2.2/farm";
  // static const String server = "http://192.168.1.4/farm";
  // static const String server = "http://farm2024.free.nf/farm/";

  static  String server = "http://192.168.1.8/farm";


  static  String test = "$server/test.php";

  // ========================== auth ======================//
  static  String signUp = "$server/auth/signup.php";
  static  String login = "$server/auth/login.php";
  static  String farmSignUp = "$server/auth/farmSignup.php";
  static  String loginFarm = "$server/auth/loginFarm.php";



  // ============================== profile ================================== //
  static  String deleteAccount = "$server/profile/deletAccount.php" ;
  static  String editInfo = "$server/profile/editInfo.php" ;


  // ================================ home page ===============================//
  static  String homepage = "$server/home/get_data_home.php" ;


  // ================================ booking ==================================//

  static  String getBooking = "$server/booking/get_booking.php" ;
  static  String addBooking = "$server/booking/add_booking.php" ;
  static  String get_user_booking = "$server/booking/get_user_booking.php" ;



  static  String deleteBooking = "$server/booking/delete_booking.php" ;



  static  String get_Works = "$server/manager/get_works.php" ;


  // ================================ notification =============================//
  static  String sendMessage = "https://fcm.googleapis.com/fcm/send" ;



  static  String search = "$server//search/getService.php" ;



  /////////////////////////////////// farm //////////////////////////////////////////

  static  String addRate = "$server/rateFarm/addRate.php" ;
  static  String getRate = "$server/rateFarm/getRate.php" ;


  ///////////////////////////////// admin ///////////////////////////////////////////

  static  String get_pending_farms = "$server/manager/get_pending_farms.php" ;

  static  String delete_farm = "$server/manager/delete_farm.php" ;

  static  String updateStatus = "$server/manager/updateStatus.php" ;


  //////////////////////////////// farm owner ///////////////////////////////////////////

  static  String getImage = "$server/farm/get_image.php" ;
  static  String deleteImage = "$server/farm/deleteImage.php" ;
  static  String addImage = "$server/farm/addImage.php" ;
  static  String getFarmBooking = "$server/farm/getFarmBooking.php" ;
  static  String confirmBooking = "$server/farm/confirmBooking.php" ;
  static  String rejectBooking = "$server/farm/rejectBooking.php" ;
  static  String addOffer = "$server/farm/addOffer.php" ;
  static  String getFarmOffers = "$server/farm/getFarmOffers.php" ;








}