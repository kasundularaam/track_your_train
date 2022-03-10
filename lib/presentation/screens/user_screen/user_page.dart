import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart" as latLng;

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
                  point: latLng.LatLng(lat, long),
                  builder: (ctx) => const Icon(
                    Icons.train_rounded,
                    size: 40,
                    color: Colors.red,
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
