import "package:latlong2/latlong.dart" as latLng;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sizer/sizer.dart';
import 'package:track_your_train/logic/cubit/all_trains_cubit/all_trains_cubit.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../data/models/type_user.dart';
import '../../../../logic/cubit/get_location_cubit/get_location_cubit.dart';
import '../../../../logic/cubit/sign_out_cubit/sign_out_cubit.dart';
import '../../widgets/sign_out_window.dart';
import 'widgets/detail_view.dart';

class UserPage extends StatefulWidget {
  final TypeUser typeUser;
  const UserPage({
    Key? key,
    required this.typeUser,
  }) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  TypeUser get typeUser => widget.typeUser;
  @override
  void dispose() {
    super.dispose();
    BlocProvider.of<AllTrainsCubit>(context).dispose();
  }

  MapController mapController = MapController();

  List<Marker> markers = [];

  showTrainDetails({required String trainId}) => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(5.w),
          ),
        ),
        backgroundColor: Colors.white,
        builder: (sheetContext) {
          return DetailView(
            sheetContext: sheetContext,
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AllTrainsCubit>(context).loadTrains();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 5.w,
                ),
                Expanded(
                  child: Text(
                    "Track Your Train",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (sheetContext) {
                        return BlocProvider(
                          create: (context) => SignOutCubit(),
                          child: const SignOutWindow(),
                        );
                      }),
                  child: const Icon(
                    Icons.menu_rounded,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            Expanded(
              child: BlocListener<AllTrainsCubit, AllTrainsState>(
                listener: (context, state) {
                  if (state is AllTrainsLoaded) {
                    setState(() {
                      markers = state.markers;
                    });
                  }
                },
                child: FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    center: latLng.LatLng(6.9271, 79.8612),
                    zoom: 15.0,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                      attributionBuilder: (_) =>
                          const Text("© OpenStreetMap contributors"),
                    ),
                    MarkerLayerOptions(
                      markers: markers,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
