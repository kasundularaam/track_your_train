part of 'show_bookings_cubit.dart';

@immutable
abstract class ShowBookingsState {}

class ShowBookingsInitial extends ShowBookingsState {}

class ShowBookingsLoading extends ShowBookingsState {}

class ShowBookingsLoaded extends ShowBookingsState {
  final List<Booking> bookings;
  ShowBookingsLoaded({
    required this.bookings,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShowBookingsLoaded && listEquals(other.bookings, bookings);
  }

  @override
  int get hashCode => bookings.hashCode;

  @override
  String toString() => 'ShowBookingsLoaded(bookings: $bookings)';
}

class ShowBookingsFailed extends ShowBookingsState {
  final String errorMsg;
  ShowBookingsFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShowBookingsFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'ShowBookingsFailed(errorMsg: $errorMsg)';
}
