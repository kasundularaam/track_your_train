part of 'check_tickets_cubit.dart';

@immutable
abstract class CheckTicketsState {}

class CheckTicketsInitial extends CheckTicketsState {}

class CheckTicketsLoading extends CheckTicketsState {}

class CheckTicketsValid extends CheckTicketsState {}

class CheckTicketsInvalid extends CheckTicketsState {}

class CheckTicketsFailed extends CheckTicketsState {
  final String errorMsg;
  CheckTicketsFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CheckTicketsFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'CheckTicketsFailed(errorMsg: $errorMsg)';
}
