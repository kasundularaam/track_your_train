import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:track_your_train/core/themes/app_colors.dart';

import '../../../../../data/models/train_location.dart';

class MarkerView extends StatelessWidget {
  final TrainLocation trainLocation;
  const MarkerView({
    Key? key,
    required this.trainLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 1.h,
          ),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: Text(
            trainLocation.trainName,
            style: TextStyle(
              color: AppColors.lightElv0,
              fontSize: 12.sp,
            ),
          ),
        )
      ],
    );
  }
}
