import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth/login_controler.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/functions/validinput.dart';
import '../../widget/auth/custombuttonauth.dart';
import '../../widget/auth/CustonTextFormAuth.dart';
import '../../widget/auth/customtextbodyauth.dart';
import '../../widget/auth/customtexttitleauth.dart';
import '../../widget/auth/logoauth.dart';
import '../ChangeIpScreen.dart';
import '../../../core/constant/color.dart';

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
            ? const CircularProgressIndicator()
            : WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: HandlingDataRequest(
            statusRequest: controller.statusRequest!,
            widget: Container(
              padding: const EdgeInsets.all(16.0),
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
                    SizedBox(height: 15),
                    // زر إنشاء حساب كمزرعة
                    OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        side: MaterialStateProperty.all(BorderSide(color: AppColor.primaryColor)),
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 16.0)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Get.offNamed("/farm_signup");
                      },
                      child: Text(
                        "Create a Farm Account",
                        style: TextStyle(color: AppColor.primaryColor),
                      ),
                    ),
                    SizedBox(height: 15),
                    // زر إنشاء حساب مستخدم
                    OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        side: MaterialStateProperty.all(BorderSide(color: AppColor.primaryColor)),
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 16.0)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        controller.goToSignUp();
                      },
                      child: Text(
                        "Create a User Account",
                        style: TextStyle(color: AppColor.primaryColor),
                      ),
                    ),
                    SizedBox(height: 15),
                    // زر تغيير IP
                    OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        side: MaterialStateProperty.all(BorderSide(color: AppColor.primaryColor)),
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 16.0)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Get.to(() => ChangeIpScreen());
                      },
                      child: Text(
                        "Change Server IP",
                        style: TextStyle(color: AppColor.primaryColor),
                      ),
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
