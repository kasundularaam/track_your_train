import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:track_your_train/logic/cubit/booking_card_cubit/booking_card_cubit.dart';
import 'package:track_your_train/presentation/screens/user/bookings_screen/widgets/booking_card.dart';

import '../../../../core/components/components.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../data/models/booking.dart';
import '../../../../logic/cubit/show_bookings_cubit/show_bookings_cubit.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({Key? key}) : super(key: key);

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ShowBookingsCubit>(context).loadBookings();
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Row(
                children: [
                  Expanded(
                    child: textL("Bookings", 16, bold: true),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(5.w),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.lightElv1,
                  ),
                  child: Center(
                    child: BlocConsumer<ShowBookingsCubit, ShowBookingsState>(
                      listener: (context, state) {
                        if (state is ShowBookingsFailed) {
                          showSnackBar(context, state.errorMsg);
                        }
                      },
                      builder: (context, state) {
                        if (state is ShowBookingsLoading) {
                          return Center(child: viewSpinner());
                        }
                        if (state is ShowBookingsLoaded) {
                          return ListView(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            children: [
                              vSpacer(3),
                              ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.bookings.length,
                                  itemBuilder: (context, index) {
                                    final Booking booking =
                                        state.bookings[index];
                                    return BlocProvider(
                                      create: (context) => BookingCardCubit(),
                                      child: BookingCard(booking: booking),
                                    );
                                  }),
                            ],
                          );
                        }
                        return Center(child: nothing);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
