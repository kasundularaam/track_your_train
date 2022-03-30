import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';
import 'package:track_your_train/data/models/booking.dart';
import 'package:track_your_train/logic/cubit/booking_cubit/booking_cubit.dart';
import 'package:track_your_train/presentation/screens/user/book_train_screen/widgets/booking_input.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../data/models/train_details.dart';

class BookTrainPage extends StatefulWidget {
  final TrainDetails trainDetails;
  const BookTrainPage({
    Key? key,
    required this.trainDetails,
  }) : super(key: key);

  @override
  State<BookTrainPage> createState() => _BookTrainPageState();
}

class _BookTrainPageState extends State<BookTrainPage> {
  TrainDetails get trainDetails => widget.trainDetails;
  String get trainName => trainDetails.trainName == ""
      ? "${trainDetails.trainNumber} ${trainDetails.startStation} to ${trainDetails.endStation}"
      : trainDetails.trainName.replaceAll(RegExp(r"\s+"), " ");
  TextEditingController nicController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ticketsController = TextEditingController();

  bookTrain() {
    Booking booking = Booking(
        userNic: nicController.text,
        userName: nameController.text,
        userEmail: emailController.text,
        userPhone: phoneController.text,
        ticketCount: int.parse(ticketsController.text),
        trainId: trainDetails.trainNumber);
    BlocProvider.of<BookingCubit>(context).addBooking(booking: booking);
  }

  clearText() {
    nicController.clear();
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    ticketsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            color: AppColors.primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.lightElv0,
                    size: 22.sp,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Booking $trainName",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.lightElv0,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              children: [
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  "NIC",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 12.sp,
                  ),
                ),
                BookingInput(
                    controller: nicController,
                    keyboardType: TextInputType.name),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  "Full name",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 12.sp,
                  ),
                ),
                BookingInput(
                    controller: nameController,
                    keyboardType: TextInputType.text),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  "Email Address",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 12.sp,
                  ),
                ),
                BookingInput(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  "Phone",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 12.sp,
                  ),
                ),
                BookingInput(
                    controller: phoneController,
                    keyboardType: TextInputType.phone),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  "Ticked Count",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 12.sp,
                  ),
                ),
                BookingInput(
                    controller: ticketsController,
                    keyboardType: TextInputType.number),
                SizedBox(
                  height: 5.h,
                ),
                Center(
                  child: BlocConsumer<BookingCubit, BookingState>(
                    listener: (context, state) {
                      if (state is BookingFailed) {
                        SnackBar snackBar =
                            SnackBar(content: Text(state.errorMsg));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      if (state is BookingSucceed) {
                        SnackBar snackBar = const SnackBar(
                            content: Text("Train booked successfully!"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        clearText();
                      }
                    },
                    builder: (context, state) {
                      if (state is BookingLoading) {
                        return const CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        );
                      } else {
                        return ElevatedButton(
                          onPressed: () => bookTrain(),
                          child: Text(
                            'Book',
                            style: TextStyle(fontSize: 18.sp),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 1.5.h),
                            shape: const StadiumBorder(),
                            primary: AppColors.primaryColor,
                          ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
