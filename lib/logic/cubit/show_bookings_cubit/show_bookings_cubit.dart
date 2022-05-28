import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../data/firebase/booking_repo.dart';
import '../../../data/models/booking.dart';
import '../../../data/models/type_user.dart';
import '../../../data/shared/shared_auth.dart';

part 'show_bookings_state.dart';

class ShowBookingsCubit extends Cubit<ShowBookingsState> {
  ShowBookingsCubit() : super(ShowBookingsInitial());

  Future loadBookings() async {
    try {
      emit(ShowBookingsLoading());
      final TypeUser user = await SharedAuth.getUser();
      final List<Booking> bookings =
          await BookingRepo.getBookings(uid: user.userId);

      emit(ShowBookingsLoaded(bookings: bookings));
    } catch (e) {
      emit(ShowBookingsFailed(errorMsg: e.toString()));
    }
  }
}
