import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../data/models/train_details.dart';

class BookTrainPage extends StatefulWidget {
  final TrainDetails trainDetails;
  const BookTrainPage({
    Key? key,
    required this.trainDetails,
  }) : super(key: key);

  @override
  State<BookTrainPage> createState() => _BookTrainPageState();
}

class _BookTrainPageState extends State<BookTrainPage> {
  TrainDetails get trainDetails => widget.trainDetails;
  String get trainName => trainDetails.trainName == ""
      ? "${trainDetails.trainNumber} ${trainDetails.startStation} to ${trainDetails.endStation}"
      : trainDetails.trainName.replaceAll(RegExp(r"\s+"), " ");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            color: AppColors.primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.lightElv0,
                    size: 22.sp,
                  ),
                ),
                Expanded(
                  child: Text(
                    trainName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.lightElv0,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
