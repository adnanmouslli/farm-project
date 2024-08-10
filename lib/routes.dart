import 'package:farm/test_view.dart';
import 'package:farm/view/screen/OnBoarding.dart';
import 'package:farm/view/screen/admin/ConfirmFarm.dart';

import 'package:farm/view/screen/auth/signUp.dart';
import 'package:farm/view/screen/auth/success_signup.dart';
import 'package:farm/view/screen/booking/CancelBooking.dart';
import 'package:farm/view/screen/booking/ConfirmBooking.dart';
import 'package:farm/view/screen/booking/bookingServices.dart';
import 'package:farm/view/screen/home/homescreen.dart';
import 'package:farm/view/screen/farmdetails.dart';
import 'package:farm/view/screen/services/services.dart';
import 'package:farm/view/screen/services/servicesdetails.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'core/constant/routes.dart';


import 'core/middleware/mymiddleware.dart';
import 'view/screen/auth/login.dart';

List<GetPage<dynamic>>? routes = [

   GetPage(name: "/", page: () => const OnBoarding() , middlewares: [
  MyMiddleWare()
   ]),

 // GetPage(name: "/", page: () =>  const OnBoarding()) ,


  GetPage(name: AppRoute.login, page: () => const Login()),
  GetPage(name: AppRoute.signup, page: () => const SignUp()),
  GetPage(name: AppRoute.successSignUp, page: () => const SuccessSignUp()),
  GetPage(name: AppRoute.onBoarding, page: () => const OnBoarding()),
  GetPage(name: AppRoute.homePage, page: () =>  HomeScreen()),
  GetPage(name: AppRoute.items, page: () => const Services()),
  GetPage(name: AppRoute.FarmDetails, page: () => const FarmDetails()),

  ////////////////////////////////////////////////
  GetPage(name: AppRoute.ServicesDetails, page: () => const ServicesDetails()),
  GetPage(name: AppRoute.BookingServices, page: () => const BookingServices()),
  GetPage(name: AppRoute.CancelBooking, page: () => const CancelBooking()),
  GetPage(name: AppRoute.ConfirmFarm, page: () => const ConfirmFarm()),





  GetPage(name: "/TestView", page: () => const TestView()),





];