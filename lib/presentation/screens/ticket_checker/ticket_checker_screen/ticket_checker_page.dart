import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../data/models/type_user.dart';
import '../../../../logic/cubit/sign_out_cubit/sign_out_cubit.dart';
import '../../widgets/sign_out_window.dart';

class TicketCheckerPage extends StatefulWidget {
  final TypeUser typeUser;
  const TicketCheckerPage({
    Key? key,
    required this.typeUser,
  }) : super(key: key);

  @override
  State<TicketCheckerPage> createState() => _TicketCheckerPageState();
}

class _TicketCheckerPageState extends State<TicketCheckerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  TypeUser get typeUser => widget.typeUser;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      log(scanData.code!);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.lightElv0,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.lightElv0,
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
                      "Ticket Checker",
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
                child: Stack(
                  children: [
                    QRView(
                      key: qrKey,
                      onQRViewCreated: onQRViewCreated,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: 3.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(2.w),
                        ),
                        child: Text(
                          "Place QR code inside the area\nScanning will start automatically",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.lightElv0.withOpacity(0.9),
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 70.w,
                        height: 70.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.w,
                            color: AppColors.primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(5.w),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
