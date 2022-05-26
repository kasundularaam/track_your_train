import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:track_your_train/core/components/components.dart';

import 'package:track_your_train/data/models/train_location.dart';

import '../../../../../core/constants/strings.dart';
import '../../../../../core/themes/app_colors.dart';

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
      padding: EdgeInsets.all(5.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
            child: Image.asset(
              Strings.trainProfileImg,
              width: 30.w,
              height: 30.w,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
            child: const Divider(
              color: AppColors.darkElv1,
            ),
          ),
          Row(
            children: [
              Text(
                "Train:",
                style: TextStyle(
                    color: AppColors.darkElv0,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: 2.w,
              ),
              Expanded(
                child: Text(
                  trainLocation.trainName,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: AppColors.darkElv1,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          vSpacer(2),
          Row(
            children: [
              Text(
                "Train Id:",
                style: TextStyle(
                    color: AppColors.darkElv0,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: 2.w,
              ),
              Expanded(
                child: Text(
                  trainLocation.trainId,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: AppColors.darkElv1,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
