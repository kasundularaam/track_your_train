import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/booking.dart';

class BookingRepo {
  static CollectionReference bookingsRef =
      FirebaseFirestore.instance.collection("bookings");

  static Future<void> addBooking({required Booking booking}) async {
    try {
      await bookingsRef.doc(booking.id).set(booking.toMap());
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<bool> isBookingExists({required String id}) async {
    try {
      DocumentSnapshot snapshot = await bookingsRef.doc(id).get();
      return snapshot.exists;
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<bool> isBookingValid({required String id}) async {
    try {
      Booking booking = await getBooking(id: id);
      if (!booking.checked) {
        await bookingsRef.doc(id).update({"checked": true});
        return true;
      }
      throw "Booking not valid";
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<Booking> getBooking({required String id}) async {
    try {
      Booking booking = await bookingsRef.doc(id).get().then(
            (doc) => Booking.fromMap(doc.data() as Map<String, dynamic>),
          );
      return booking;
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<List<Booking>> getBookings({required String uid}) async {
    try {
      QuerySnapshot snapshot =
          await bookingsRef.where("uid", isEqualTo: uid).get();
      List<Booking> bookings = snapshot.docs
          .map((doc) => Booking.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return bookings;
    } catch (e) {
      throw e.toString();
    }
  }
}
