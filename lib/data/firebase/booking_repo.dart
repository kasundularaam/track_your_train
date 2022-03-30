import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:track_your_train/data/models/booking.dart';

class BookingRepo {
  static CollectionReference bookingsRef =
      FirebaseFirestore.instance.collection("bookings");

  static Future<void> addBooking({required Booking booking}) async {
    try {
      await bookingsRef.add(booking.toMap());
    } catch (e) {
      throw e.toString();
    }
  }
}
