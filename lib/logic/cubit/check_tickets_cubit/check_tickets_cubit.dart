import 'package:bloc/bloc.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:meta/meta.dart';
import 'package:track_your_train/data/firebase/booking_repo.dart';

part 'check_tickets_state.dart';

class CheckTicketsCubit extends Cubit<CheckTicketsState> {
  CheckTicketsCubit() : super(CheckTicketsInitial());

  Future scanTicketQR() async {
    try {
      emit(CheckTicketsLoading());
      String result = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      if (result == "-1") {
        emit(CheckTicketsFailed(errorMsg: "No QR detected."));
      } else {
        final bool valid = await BookingRepo.isBookingValid(id: result);
        emit(CheckTicketsValid());
      }
    } catch (e) {
      emit(CheckTicketsFailed(errorMsg: e.toString()));
    }
  }

  initial() => emit(CheckTicketsInitial());
}
