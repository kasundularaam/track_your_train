import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../router/app_router.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_input.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPwController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightElv0,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 5.h,
            ),
            Text(
              "SIGN UP",
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              "Please fill the fields below here",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              "Full Name",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 12.sp,
              ),
            ),
            AuthTextInput(
              controller: nameController,
              keyboardType: TextInputType.name,
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              "email address",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 12.sp,
              ),
            ),
            AuthTextInput(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              "Password",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 12.sp,
              ),
            ),
            AuthTextInput(
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              isPassword: true,
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              "Confirm Password",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 12.sp,
              ),
            ),
            AuthTextInput(
              controller: confirmPwController,
              keyboardType: TextInputType.visiblePassword,
              isPassword: true,
            ),
            SizedBox(
              height: 5.h,
            ),
            Center(
                child: AuthButton(
              text: "SIGN IN",
              onPress: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRouter.landingPage, (route) => false),
            )),
            SizedBox(
              height: 5.h,
            ),
            Center(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Already have an account?",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: " LOG IN",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.of(context)
                          .pushNamedAndRemoveUntil(
                              AppRouter.loginPage, (route) => false),
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
          ],
        ),
      ),
    );
  }
}
