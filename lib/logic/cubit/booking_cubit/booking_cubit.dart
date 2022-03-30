import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:track_your_train/data/firebase/booking_repo.dart';

import '../../../data/models/booking.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());

  Future<void> addBooking({required Booking booking}) async {
    try {
      emit(BookingLoading());
      await BookingRepo.addBooking(booking: booking);
      emit(BookingSucceed());
    } catch (e) {
      emit(BookingFailed(errorMsg: e.toString()));
    }
  }
}
