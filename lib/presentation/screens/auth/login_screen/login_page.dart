import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:track_your_train/core/components/components.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../logic/cubit/login_cubit/login_cubit.dart';
import '../../../router/app_router.dart';
import '../widgets/auth_text_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  void login() {
    final String email = emailCtrl.text;
    final String password = passwordCtrl.text;
    BlocProvider.of<LoginCubit>(context).login(
      email: email,
      password: password,
    );
  }

  void clearControllers() {
    emailCtrl.clear();
    passwordCtrl.clear();
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
            vSpacer(20),
            Center(
              child: Text(
                "LOGIN",
                style: TextStyle(
                    color: AppColors.lightElv0,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            vSpacer(3),
            Card(
              child: Padding(
                padding: EdgeInsets.all(5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textP("Please Sign in to continue", 12, bold: true),
                    vSpacer(5),
                    textP("Email", 12),
                    vSpacer(1),
                    inputText(emailCtrl, hint: "example@tyt.com"),
                    vSpacer(2),
                    textP("Password", 12),
                    vSpacer(1),
                    inputPassword(passwordCtrl, hint: "* * * * * * *"),
                    vSpacer(5),
                    Center(
                      child: BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state is LoginSucceed) {
                            clearControllers();
                            navAndClear(context, AppRouter.landingPage);
                          } else if (state is LoginFailed) {
                            SnackBar snackBar =
                                SnackBar(content: Text(state.errorMsg));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        builder: (context, state) {
                          if (state is LoginLoading) {
                            return const CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            );
                          } else {
                            return buttonFilledP("LOG IN", () => login());
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            vSpacer(5),
            Center(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Don't have an account?",
                    style: TextStyle(
                      color: AppColors.lightElv0,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: " SIGN UP",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.of(context)
                          .pushNamedAndRemoveUntil(
                              AppRouter.signInPage, (route) => false),
                    style: TextStyle(
                      color: AppColors.lightElv0,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ]),
              ),
            ),
            vSpacer(5),
          ],
        ),
      ),
    );
  }
}
