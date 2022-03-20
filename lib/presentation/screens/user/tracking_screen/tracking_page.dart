import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:track_your_train/core/themes/app_colors.dart';
import 'package:track_your_train/logic/cubit/tracking_map_cubit/tracking_map_cubit.dart';
import 'package:track_your_train/presentation/screens/user/tracking_screen/widget/tracking_map.dart';

import '../../../../data/models/train_details.dart';

class TrackingPage extends StatefulWidget {
  final TrainDetails trainDetails;
  const TrackingPage({
    Key? key,
    required this.trainDetails,
  }) : super(key: key);

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
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
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
            color: AppColors.primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close_rounded,
                      color: AppColors.lightElv0,
                      size: 22.sp,
                    ))
              ],
            ),
          ),
          Expanded(
              child: BlocProvider(
            create: (context) => TrackingMapCubit(),
            child: TrackingMap(
              trainId: trainDetails.trainNumber,
            ),
          )),
        ],
      ),
    ));
  }
}
