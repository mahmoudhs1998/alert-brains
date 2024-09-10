import 'package:alert_brains/app/modules/auth/controllers/auth_controllers.dart';
import 'package:alert_brains/global_presentation/build_elevated_button.dart';
import 'package:alert_brains/global_presentation/build_text.dart';
import 'package:alert_brains/global_presentation/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignInSignUpScreen extends StatelessWidget {
  const SignInSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30.0.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60.h,
              ),
              BuildText(
                text: "Welcome Back",
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xff7BC05B),
              ),
              BuildText(
                text: "Login to your account!",
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              Center(
                child: SizedBox(
                  width: 250.w,
                  height: 300.h,
                  child: Image.asset(
                    'assets/images/SignIn_SignUp.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: Obx(
                  () {
                    final isSigningIn = authController.isSigningIn.value;
                    return isSigningIn
                        ? const LoadingIndicator(isLoading: true)
                        : BuildElevatedButton(
                            onPressed: authController.signInWithGoogle,
                            title: 'Sign in with Google',
                            widget: SizedBox(
                              height: 20.h,
                              child:  SvgPicture.asset("assets/images/google.svg"),
                            ),
                            color: Color(0xff7BC05B),
                          );
                  },
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: BuildElevatedButton(
                  onPressed: authController.signInWithGoogle,
                  title: 'Play without an account',
                  color: Color(0xffFFB61D),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
