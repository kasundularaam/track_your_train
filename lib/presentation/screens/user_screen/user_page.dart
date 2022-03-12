import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart" as latLng;
import 'package:sizer/sizer.dart';
import 'package:track_your_train/core/themes/app_colors.dart';
import 'package:track_your_train/presentation/screens/auth/widgets/auth_button.dart';

import '../../../logic/cubit/get_location_cubit/get_location_cubit.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void dispose() {
    super.dispose();
    BlocProvider.of<GetLocationCubit>(context).dispose();
  }

  MapController mapController = MapController();

  double lat = 0;
  double long = 0;

  showTrainDetails() => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(5.w),
          ),
        ),
        backgroundColor: Colors.white,
        builder: (sheetContext) {
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
        },
      );

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetLocationCubit>(context).getLocation();
    return Scaffold(
      body: BlocListener<GetLocationCubit, GetLocationState>(
        listener: (context, state) {
          if (state is GetLocationGetting) {
            setState(() {
              lat = state.latLong.lat;
              long = state.latLong.long;
            });

            mapController.move(latLng.LatLng(lat, long), 15.0);
          }
        },
        child: FlutterMap(
          mapController: mapController,
          options: MapOptions(
            center: latLng.LatLng(0, 0),
            zoom: 15.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
              attributionBuilder: (_) =>
                  const Text("© OpenStreetMap contributors"),
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  height: 10.w,
                  width: 10.w,
                  point: latLng.LatLng(
                    lat,
                    long,
                  ),
                  builder: (ctx) => GestureDetector(
                    onTap: () => showTrainDetails(),
                    child: Image.asset(
                      "assets/images/train.png",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
