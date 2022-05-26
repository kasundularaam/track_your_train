import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:track_your_train/logic/cubit/register_cubit/register_cubit.dart';

import '../../../../core/components/components.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../router/app_router.dart';
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

  void register() {
    final String name = nameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmPwController.text;
    BlocProvider.of<RegisterCubit>(context).register(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  void clearControllers() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPwController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          physics: const BouncingScrollPhysics(),
          children: [
            vSpacer(5),
            Center(child: textL("SIGN UP", 30, bold: true)),
            vSpacer(5),
            Card(
              child: Padding(
                padding: EdgeInsets.all(5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textP("Please fill the fields below here", 12, bold: true),
                    vSpacer(5),
                    textP("Full Name", 12),
                    vSpacer(1),
                    inputText(nameController, hint: "example"),
                    vSpacer(2),
                    textP("Email", 12),
                    vSpacer(1),
                    inputText(emailController, hint: "example@tyt.com"),
                    vSpacer(2),
                    textP("Password", 12),
                    vSpacer(1),
                    inputPassword(passwordController, hint: "* * * * * * *"),
                    vSpacer(2),
                    textP("Confirm Password", 12),
                    vSpacer(1),
                    inputPassword(confirmPwController, hint: "* * * * * * *"),
                    vSpacer(5),
                    Center(
                      child: BlocConsumer<RegisterCubit, RegisterState>(
                        listener: (context, state) {
                          if (state is RegisterSucceed) {
                            navAndClear(context, AppRouter.landingPage);
                          }
                          if (state is RegisterFailed) {
                            showSnackBar(context, state.errorMsg);
                          }
                        },
                        builder: (context, state) {
                          if (state is RegisterLoading) {
                            return viewSpinner();
                          } else {
                            return buttonFilledP("Register", () => register());
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Center(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Already have an account?",
                    style: TextStyle(
                      color: AppColors.lightElv0,
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
                      color: AppColors.lightElv0,
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
