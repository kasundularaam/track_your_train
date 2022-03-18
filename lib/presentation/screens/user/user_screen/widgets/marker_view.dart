import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:track_your_train/core/themes/app_colors.dart';
import 'package:track_your_train/presentation/screens/user/user_screen/widgets/detail_view.dart';

import '../../../../../data/models/train_location.dart';

class MarkerView extends StatelessWidget {
  final TrainLocation trainLocation;
  const MarkerView({
    Key? key,
    required this.trainLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Column(
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
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                color: AppColors.lightElv0,
                fontSize: 12.sp,
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          GestureDetector(
            onTap: () => showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(5.w),
                  ),
                ),
                backgroundColor: AppColors.lightElv0,
                isScrollControlled: true,
                builder: (sheetContext) =>
                    DetailView(sheetContext: sheetContext)),
            child: Image.asset(
              "assets/images/train.png",
              width: 10.w,
              height: 10.w,
            ),
          )
        ],
      ),
    );
  }
}
