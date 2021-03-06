import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../data/converters/string_formatter.dart';
import '../../../../data/models/train_details.dart';
import '../../../../logic/cubit/tracking_map_cubit/tracking_map_cubit.dart';
import '../../../router/app_router.dart';
import 'widget/tracking_map.dart';

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

  bool get noBooking {
    if (trainDetails.availableClasses.contains("1st Class")) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
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
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(5.w)),
                  child: Container(
                    color: AppColors.lightElv0,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: BlocProvider(
                            create: (context) => TrackingMapCubit(),
                            child: TrackingMap(
                              trainId: trainDetails.trainNumber,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 1.h,
                                ),
                                Center(
                                  child: Text(
                                    trainDetails.titleText,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: "Train number: ",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColors.darkElv1,
                                      ),
                                    ),
                                    TextSpan(
                                      text: StringFormatter.capitalize(
                                          string: trainDetails.trainNumber),
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
                                      text: "Start Station: ",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColors.darkElv1,
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
                                      text: "End Station: ",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColors.darkElv1,
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
                                RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: "Departure Time: ",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColors.darkElv1,
                                      ),
                                    ),
                                    TextSpan(
                                      text: StringFormatter.capitalize(
                                          string: trainDetails.departureTime),
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
                                Container(
                                  color: AppColors.darkElv0.withOpacity(0.2),
                                  width: 100.w,
                                  height: 0.2.h,
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Flexible(
                                  child: ListView(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Run By",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: AppColors.darkElv1,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Chip(
                                            label: Text(
                                              trainDetails.runby,
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            backgroundColor: AppColors
                                                .primaryColor
                                                .withOpacity(0.25),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Container(
                                        width: 1.w,
                                        height: 1.w,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.darkElv0,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Train Type",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: AppColors.darkElv1,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Chip(
                                            label: Text(
                                              trainDetails.trainType,
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            backgroundColor: AppColors
                                                .primaryColor
                                                .withOpacity(0.25),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Container(
                                        width: 1.w,
                                        height: 1.w,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.darkElv0,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Direct Train",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: AppColors.darkElv1,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Chip(
                                            label: Text(
                                              trainDetails.directtrain,
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            backgroundColor: AppColors
                                                .primaryColor
                                                .withOpacity(0.25),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Container(
                                  color: AppColors.darkElv0.withOpacity(0.2),
                                  width: 100.w,
                                  height: 0.2.h,
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  "Available Classes",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.darkElv0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Flexible(
                                  child: ListView(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    children: trainDetails.availableClasses
                                        .map(
                                          (trainClass) => Row(
                                            children: [
                                              Chip(
                                                label: Text(
                                                  trainClass,
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                backgroundColor: AppColors
                                                    .primaryColor
                                                    .withOpacity(0.25),
                                              ),
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Center(
                                  child: IgnorePointer(
                                    ignoring: !noBooking,
                                    child: ElevatedButton(
                                      onPressed: () => Navigator.pushNamed(
                                        context,
                                        AppRouter.bookTrainPage,
                                        arguments: trainDetails,
                                      ),
                                      child: Text(
                                        'Book Now',
                                        style: TextStyle(fontSize: 18.sp),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w,
                                              vertical: 1.5.h),
                                          shape: const StadiumBorder(),
                                          primary: noBooking
                                              ? AppColors.primaryColor
                                              : AppColors.darkElv1),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
