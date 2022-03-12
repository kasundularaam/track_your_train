import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/themes/app_colors.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final Function onPress;
  const AuthButton({
    Key? key,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 1.5.h),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(
            4.h,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.lightElv0,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}
