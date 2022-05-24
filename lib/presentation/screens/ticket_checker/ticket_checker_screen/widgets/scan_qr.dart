import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/components/components.dart';
import '../../../../../logic/cubit/check_tickets_cubit/check_tickets_cubit.dart';

class ScanQR extends StatefulWidget {
  const ScanQR({Key? key}) : super(key: key);

  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          textD("Scan Ticket QR", 14),
          BlocConsumer<CheckTicketsCubit, CheckTicketsState>(
            listener: (context, state) {
              if (state is CheckTicketsFailed) {
                showSnackBar(context, state.errorMsg);
              }
              if (state is CheckTicketsValid) {}
              if (state is CheckTicketsInvalid) {}
            },
            builder: (context, state) {
              if (state is CheckTicketsLoading) {
                return viewSpinner();
              }
              return buttonFilledP(
                "Scan",
                () =>
                    BlocProvider.of<CheckTicketsCubit>(context).scanTicketQR(),
              );
            },
          )
        ],
      ),
    );
  }
}
