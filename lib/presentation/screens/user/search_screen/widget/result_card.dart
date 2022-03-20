import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:track_your_train/core/themes/app_colors.dart';
import 'package:track_your_train/data/converters/string_formatter.dart';
import 'package:track_your_train/presentation/router/app_router.dart';

import '../../../../../data/models/train_details.dart';

class ResultCard extends StatelessWidget {
  final TrainDetails trainDetails;
  const ResultCard({
    Key? key,
    required this.trainDetails,
  }) : super(key: key);

  List<Widget> get classes {
    List<Chip> chips = [];
    for (var tClass in trainDetails.availableClasses) {
      chips.add(Chip(
          backgroundColor: AppColors.primaryColor.withOpacity(0.15),
          label: Text(tClass)));
    }
    return chips;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, AppRouter.trackingPage,
              arguments: trainDetails),
          child: Container(
            width: 100.w,
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
            decoration: BoxDecoration(
                color: AppColors.lightElv0,
                borderRadius: BorderRadius.circular(2.w)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trainDetails.titleText,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.darkElv0,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "From: ",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    TextSpan(
                      text: StringFormatter.capitalize(
                          string: trainDetails.startStation),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.darkElv0,
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 1.h,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "To: ",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    TextSpan(
                      text: StringFormatter.capitalize(
                          string: trainDetails.endStation),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.darkElv0,
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Wrap(
                  spacing: 2.w,
                  children: classes,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
      ],
    );
  }
}
