import "package:latlong2/latlong.dart" as latLng;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../data/models/type_user.dart';
import '../../../../logic/cubit/send_location_cubit/send_location_cubit.dart';
import '../../../../logic/cubit/sign_out_cubit/sign_out_cubit.dart';
import '../../widgets/sign_out_window.dart';

class DriverPage extends StatefulWidget {
  final TypeUser typeUser;
  const DriverPage({
    Key? key,
    required this.typeUser,
  }) : super(key: key);

  @override
  _DriverPageState createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  TypeUser get typeUser => widget.typeUser;

  @override
  void dispose() {
    super.dispose();
    BlocProvider.of<SendLocationCubit>(context).dispose();
  }

  MapController mapController = MapController();

  double lat = 0;
  double long = 0;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SendLocationCubit>(context).sendLocation();
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
                    "On The Way",
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
              child: BlocListener<SendLocationCubit, SendLocationState>(
                listener: (context, state) {
                  if (state is SendLocationSending) {
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
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                      attributionBuilder: (_) =>
                          const Text("© OpenStreetMap contributors"),
                    ),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          point: latLng.LatLng(lat, long),
                          builder: (ctx) =>
                              Image.asset("assets/images/train.png"),
                        ),
                      ],
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
