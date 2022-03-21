import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:track_your_train/core/themes/app_colors.dart';
import 'package:track_your_train/logic/cubit/tracking_map_cubit/tracking_map_cubit.dart';
import 'package:track_your_train/presentation/screens/user/tracking_screen/widget/tracking_map.dart';

import '../../../../data/converters/string_formatter.dart';
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
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
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
                              backgroundColor:
                                  AppColors.primaryColor.withOpacity(0.25),
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
                              backgroundColor:
                                  AppColors.primaryColor.withOpacity(0.25),
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
                              backgroundColor:
                                  AppColors.primaryColor.withOpacity(0.25),
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
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  backgroundColor:
                                      AppColors.primaryColor.withOpacity(0.25),
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
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Book Now',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 1.5.h),
                          shape: const StadiumBorder(),
                          primary: AppColors.primaryColor),
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
    ));
  }
}
