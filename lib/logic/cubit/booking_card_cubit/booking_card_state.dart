part of 'booking_card_cubit.dart';

@immutable
abstract class BookingCardState {}

class BookingCardInitial extends BookingCardState {}

class BookingCardLoading extends BookingCardState {}

class BookingCardLoaded extends BookingCardState {
  final AppUser train;
  BookingCardLoaded({
    required this.train,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookingCardLoaded && other.train == train;
  }

  @override
  int get hashCode => train.hashCode;

  @override
  String toString() => 'BookingCardLoaded(train: $train)';
}
