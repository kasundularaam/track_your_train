import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:track_your_train/core/themes/app_colors.dart';

class ShowQrPage extends StatefulWidget {
  final String id;
  const ShowQrPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ShowQrPage> createState() => _ShowQrPageState();
}

class _ShowQrPageState extends State<ShowQrPage> {
  String get id => widget.id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightElv0,
      body: Center(
        child: QrImage(
          data: id,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
