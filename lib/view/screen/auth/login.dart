import 'package:farm/core/class/statusrequest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../controller/auth/login_controler.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/constant/color.dart';
import '../../../core/functions/alertexitapp.dart';
import '../../../core/functions/validinput.dart';
import '../../widget/auth/CustonTextFormAuth.dart';
import '../../widget/auth/customLottie.dart';
import '../../widget/auth/customTextSignup.dart';
import '../../widget/auth/custombuttonauth.dart';
import '../../widget/auth/customtextbodyauth.dart';
import '../../widget/auth/customtexttitleauth.dart';
import '../../widget/auth/logoauth.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginControlerImp());
    int x = Get.arguments != null ? Get.arguments : 0;
    StatusRequest statusRequest;

    // قائمة أنواع الحسابات
    final List<String> accountTypes = ['User', 'Farm Owner'];
    String selectedAccountType = 'User'; // القيمة الافتراضية

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.white,
        elevation: 0.0,
        title: Text(
          'Log In',
          style: Theme.of(context).textTheme.headline1!.copyWith(color: AppColor.grey),
        ),
      ),
      body: GetBuilder<LoginControlerImp>(
        builder: (controller) => !controller.isInternet
            ? const CustomLottie()
            : WillPopScope(
          onWillPop: () async {
            return alertExitApp();
          },
          child: HandlingDataRequest(
            statusRequest: controller.statusRequest!,
            widget: Container(
              child: Form(
                key: controller.formstate,
                child: ListView(
                  children: [
                    SizedBox(height: 20),
                    LogoAuth(),
                    SizedBox(height: 20),
                    CustomTextTitleAuth(text: "Welcome Back"),
                    SizedBox(height: 5),
                    CustomTextBodyAuth(
                      text: x != null && x == 1
                          ? "Verification has been sent to your email, please verify your account and then register"
                          : "Log in with your email and password or continue with social media",
                    ),
                    SizedBox(height: 40),
                    // اختيار نوع الحساب
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: DropdownButtonFormField<String>(
                        value: selectedAccountType,
                        decoration: InputDecoration(
                          labelText: "Select Account Type",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        items: accountTypes.map((String type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          selectedAccountType = newValue!;
                          controller.setAccountType(newValue);
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomTextFormAuth(
                      isnumber: false,
                      valid: (val) {
                        return validInput(val!, 5, 30, "email");
                      },
                      mycontroller: controller.email,
                      hinttext: "Enter Your Email",
                      iconData: Icons.email_outlined,
                      labeltext: "Email",
                    ),
                    SizedBox(height: 15),
                    GetBuilder<LoginControlerImp>(
                      builder: (controller) => CustomTextFormAuth(
                        isnumber: false,
                        valid: (val) {
                          return validInput(val!, 3, 30, "password");
                        },
                        obscureText: controller.isshowpassword,
                        onTapIcon: () {
                          controller.showPassword();
                        },
                        mycontroller: controller.password,
                        hinttext: "Enter Your Password",
                        iconData: Icons.lock_outline,
                        labeltext: "Password",
                      ),
                    ),
                    SizedBox(height: 30),
                    CustomButtomAuth(
                      text: "Log in",
                      onPressed: () {
                       controller.login(context);
                      },
                    ),
                    // زر تسجيل كمزرعة
                    CustomButtomAuth(
                      text: "Create a Farm Account",
                      onPressed: () {
                        Get.offNamed("/farm_signup");
                      },
                    ),
                    CustomButtomAuth(
                      text: "Create a User Account",
                      onPressed: () {
                        controller.goToSignUp();
                      },
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
