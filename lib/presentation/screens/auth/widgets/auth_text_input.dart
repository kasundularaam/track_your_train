import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/themes/app_colors.dart';

class AuthTextInput extends StatelessWidget {
  final TextEditingController controller;
  final bool? isPassword;
  final TextInputType keyboardType;
  const AuthTextInput({
    Key? key,
    required this.controller,
    this.isPassword,
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: 14.sp,
        color: AppColors.darkElv0,
      ),
      obscureText: isPassword ?? false,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: AppColors.darkElv1,
        ),
      ),
    );
  }
}
