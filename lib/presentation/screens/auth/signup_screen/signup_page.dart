import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:track_your_train/logic/cubit/register_cubit/register_cubit.dart';

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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.lightElv0,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
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
                child: BlocConsumer<RegisterCubit, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterSucceed) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRouter.landingPage,
                        (route) => false,
                      );
                    } else if (state is RegisterFailed) {
                      SnackBar snackBar = SnackBar(
                        content: Text(
                          state.errorMsg,
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  builder: (context, state) {
                    if (state is RegisterLoading) {
                      return const CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      );
                    } else {
                      return AuthButton(
                        text: "SIGN IN",
                        onPress: () => register(),
                      );
                    }
                  },
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
      ),
    );
  }
}
