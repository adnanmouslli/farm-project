class AppLink {

  static const String server = "http://10.0.2.2/farm";

  static const String test = "$server/test.php";


  // ========================== auth ======================//
  static const String signUp = "$server/auth/signup.php";
  static const String login = "$server/auth/login.php";


  // ============================== profile ================================== //
  static const String deleteAccount = "$server/profile/deletAccount.php" ;
  static const String editInfo = "$server/profile/editInfo.php" ;


  // ================================ home page ===============================//
  static const String homepage = "$server/home/get_data_home.php" ;


  // ================================ booking ==================================//

  static const String getBooking = "$server/booking/get_booking.php" ;
  static const String addBooking = "$server/booking/add_booking.php" ;
  static const String get_user_booking = "$server/booking/get_user_booking.php" ;
  static const String deleteBooking = "$server/booking/delete_booking.php" ;



  static const String get_Works = "$server/manager/get_works.php" ;


  // ================================ notification =============================//
  static const String sendMessage = "https://fcm.googleapis.com/fcm/send" ;



  static const String search = "$server//search/getService.php" ;



  /////////////////////////////////// farm //////////////////////////////////////////

  static const String addRate = "$server/rateFarm/addRate.php" ;
  static const String getRate = "$server/rateFarm/getRate.php" ;


  ///////////////////////////////// admin ///////////////////////////////////////////

  static const String get_pending_farms = "$server/manager/get_pending_farms.php" ;

  static const String delete_farm = "$server/manager/delete_farm.php" ;

  static const String updateStatus = "$server/manager/updateStatus.php" ;

}