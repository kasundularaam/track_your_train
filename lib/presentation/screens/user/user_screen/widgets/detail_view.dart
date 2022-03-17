import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../auth/widgets/auth_button.dart';
import 'package:sizer/sizer.dart';

class DetailView extends StatelessWidget {
  final BuildContext sheetContext;
  const DetailView({
    Key? key,
    required this.sheetContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 15.w,
              height: 1.2.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1.h),
                color: AppColors.lightElv1,
              ),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Center(
            child: Wrap(children: [
              Text(
                "COLOMBO FORT to KANDY",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.darkElv0,
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
            child: Text(
              "PODI MENIKE - EXPRESS TRAIN BADULLA",
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            "Start Station : COLOMBO FORT",
            style: TextStyle(
              color: AppColors.darkElv1,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            "Departure Time : 05:55:00",
            style: TextStyle(
              color: AppColors.darkElv1,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            "Arrival to KANDY	: 08:42:00",
            style: TextStyle(
              color: AppColors.darkElv1,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            "Distance : 120.7KM",
            style: TextStyle(
              color: AppColors.darkElv1,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            "Available Classes",
            style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 2.h,
          ),
          Wrap(
            spacing: 2.w,
            children: const [
              Chip(
                backgroundColor: AppColors.primaryColor,
                label: Text(
                  "1st Class",
                  style: TextStyle(
                    color: AppColors.lightElv0,
                  ),
                ),
              ),
              Chip(
                backgroundColor: AppColors.primaryColor,
                label: Text(
                  "2nd Class",
                  style: TextStyle(
                    color: AppColors.lightElv0,
                  ),
                ),
              ),
              Chip(
                backgroundColor: AppColors.primaryColor,
                label: Text(
                  "3rd Class",
                  style: TextStyle(
                    color: AppColors.lightElv0,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 3.h,
          ),
          Center(
            child: AuthButton(
              onPress: () {
                Navigator.pop(sheetContext);
              },
              text: "Track Train",
            ),
          )
        ],
      ),
    );
  }
}
