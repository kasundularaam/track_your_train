import "package:latlong2/latlong.dart" as latLng;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../../../../data/models/train_location.dart';
import '../../../../../logic/cubit/tracking_map_cubit/tracking_map_cubit.dart';

class TrackingMap extends StatefulWidget {
  final String trainId;
  const TrackingMap({
    Key? key,
    required this.trainId,
  }) : super(key: key);

  @override
  State<TrackingMap> createState() => _TrackingMapState();
}

class _TrackingMapState extends State<TrackingMap> {
  String get trainId => widget.trainId;
  MapController mapController = MapController();
  TrainLocation? trainLocation;
  List<Marker> markers = [];
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TrackingMapCubit>(context).trackTrain(trainId: trainId);
    return BlocListener<TrackingMapCubit, TrackingMapState>(
      listener: (context, state) {
        if (state is TrackingMapTracking) {
          setState(() {
            trainLocation = state.trainLocation;
            markers[0] = state.marker;
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
