import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:track_your_train/logic/cubit/check_tickets_cubit/check_tickets_cubit.dart';

import '../../../../core/components/components.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../data/models/type_user.dart';
import '../../../../logic/cubit/sign_out_cubit/sign_out_cubit.dart';
import '../../widgets/sign_out_window.dart';
import 'widgets/scan_qr.dart';

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
                  child: Container(
                color: AppColors.lightElv0,
                child: Column(
                  children: [
                    vSpacer(3),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(5.w),
                        child: Image.asset(Strings.scannerImg)),
                    vSpacer(2),
                    const ScanQR(),
                    vSpacer(3),
                    BlocBuilder<CheckTicketsCubit, CheckTicketsState>(
                      builder: (context, state) {
                        if (state is CheckTicketsValid) {
                          return Card(
                            color: Colors.green,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                                vertical: 2.h,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle_outline_rounded,
                                    color: AppColors.lightElv0,
                                    size: 22.sp,
                                  ),
                                  hSpacer(3),
                                  Expanded(
                                      child: textL("Ticket accepted", 14,
                                          bold: true)),
                                  buttonText(
                                      "OK",
                                      () => BlocProvider.of<CheckTicketsCubit>(
                                              context)
                                          .initial(),
                                      AppColors.lightElv0)
                                ],
                              ),
                            ),
                          );
                        }
                        if (state is CheckTicketsInvalid) {
                          return Card(
                            color: Colors.red,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                                vertical: 2.h,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle_outline_rounded,
                                    color: AppColors.lightElv0,
                                    size: 22.sp,
                                  ),
                                  hSpacer(3),
                                  Expanded(
                                    child: textL(
                                        "Can not accept this ticket", 14,
                                        bold: true),
                                  ),
                                  buttonText(
                                      "OK",
                                      () => BlocProvider.of<CheckTicketsCubit>(
                                              context)
                                          .initial(),
                                      AppColors.lightElv0)
                                ],
                              ),
                            ),
                          );
                        }
                        return nothing;
                      },
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
