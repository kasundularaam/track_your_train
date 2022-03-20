import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart" as latLng;
import 'package:track_your_train/logic/cubit/send_location_cubit/send_location_cubit.dart';

import '../../../../../data/models/train_location.dart';

class DriverMap extends StatefulWidget {
  const DriverMap({Key? key}) : super(key: key);

  @override
  State<DriverMap> createState() => _DriverMapState();
}

class _DriverMapState extends State<DriverMap> {
  MapController mapController = MapController();
  TrainLocation? trainLocation;
  List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendLocationCubit, SendLocationState>(
      listener: (context, state) {
        if (state is SendLocationSending) {
          setState(() {
            trainLocation = state.trainLocation;
            markers = state.markers;
          });
          mapController.move(
              latLng.LatLng(trainLocation!.latitude, trainLocation!.longitude),
              15.0);
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
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            attributionBuilder: (_) =>
                const Text("© OpenStreetMap contributors"),
          ),
          MarkerLayerOptions(
            markers: markers,
          ),
        ],
      ),
    );
  }
}
