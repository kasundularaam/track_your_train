import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/firebase/fire_train.dart';
import '../../../data/models/app_user.dart';

part 'booking_card_state.dart';

class BookingCardCubit extends Cubit<BookingCardState> {
  BookingCardCubit() : super(BookingCardInitial());

  Future loadCard({required String trainId}) async {
    try {
      emit(BookingCardLoading());
      final AppUser train = await FireTrain.getUserData(trainNumber: trainId);
      emit(BookingCardLoaded(train: train));
    } catch (e) {
      emit(BookingCardLoading());
    }
  }
}
