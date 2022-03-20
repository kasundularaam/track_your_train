import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:track_your_train/data/models/train_location.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../auth/widgets/auth_button.dart';

class DetailView extends StatelessWidget {
  final BuildContext sheetContext;
  final TrainLocation trainLocation;
  const DetailView({
    Key? key,
    required this.sheetContext,
    required this.trainLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 3.h,
          ),
          Center(
            child: Container(
              width: 15.w,
              height: 1.2.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1.h),
                color: AppColors.lightElv2,
              ),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Center(
            child: Wrap(children: [
              Text(
                trainLocation.trainName,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 2.h,
          ),
          Center(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "Train No: ",
                  style: TextStyle(
                      color: AppColors.darkElv1,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
                ),
                TextSpan(
                  text: trainLocation.trainId,
                  style: TextStyle(
                      color: AppColors.darkElv0,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold),
                )
              ]),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
        ],
      ),
    );
  }
}
