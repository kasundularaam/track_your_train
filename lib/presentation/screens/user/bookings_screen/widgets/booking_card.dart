import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/components/components.dart';
import '../../../../../core/constants/strings.dart';
import '../../../../../data/models/booking.dart';
import '../../../../../logic/cubit/booking_card_cubit/booking_card_cubit.dart';
import '../../../../router/app_router.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;
  const BookingCard({
    Key? key,
    required this.booking,
  }) : super(key: key);

  String getDate(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return "${date.day}.${date.month}.${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BookingCardCubit>(context)
        .loadCard(trainId: booking.trainId);
    return BlocBuilder<BookingCardCubit, BookingCardState>(
      builder: (context, state) {
        if (state is BookingCardLoaded) {
          return Card(
            child: Padding(
              padding: EdgeInsets.all(3.w),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textD("Train: ", 14, bold: true),
                      Expanded(child: textD(state.train.userName, 14)),
                    ],
                  ),
                  vSpacer(2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textD("Train number: ", 14, bold: true),
                      Expanded(child: textD(state.train.trainId, 14)),
                    ],
                  ),
                  vSpacer(2),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    textD("Ticket count: ", 14, bold: true),
                    Expanded(child: textD(booking.ticketCount.toString(), 14)),
                  ]),
                  vSpacer(2),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    textD("Date: ", 14, bold: true),
                    Expanded(child: textD(getDate(booking.timeStamp), 14)),
                  ]),
                  vSpacer(2),
                  Row(
                    children: [
                      Expanded(child: textD("Show QR code: ", 14, bold: true)),
                      buttonFilledP(
                        "Show",
                        () => navPush(
                          context,
                          AppRouter.showQrPage,
                          args: booking.id,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
        return Card(
          child: Padding(
              padding: EdgeInsets.all(3.w),
              child: Image.asset(Strings.bookingLoadingImg)),
        );
      },
    );
  }
}
