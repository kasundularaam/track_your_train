part of 'landing_screen_cubit.dart';

@immutable
abstract class LandingScreenState {}

class LandingScreenInitial extends LandingScreenState {}

class LandingScreenLoading extends LandingScreenState {}

class LandingScreenUser extends LandingScreenState {
  final AppUser user;
  LandingScreenUser({
    required this.user,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LandingScreenUser && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;

  @override
  String toString() => 'LandingScreenUser(user: $user)';
}

class LandingScreenTrain extends LandingScreenState {
  final AppUser user;
  LandingScreenTrain({
    required this.user,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LandingScreenTrain && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;

  @override
  String toString() => 'LandingScreenTrain(user: $user)';
}

class LandingScreenTicketChecker extends LandingScreenState {
  final TypeUser user;
  LandingScreenTicketChecker({
    required this.user,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LandingScreenTicketChecker && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;

  @override
  String toString() => 'LandingScreenTicketChecker(user: $user)';
}

class LandingScreenToAuth extends LandingScreenState {}

class LandingScreenFailed extends LandingScreenState {
  final String errorMsg;
  LandingScreenFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LandingScreenFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'LandingScreenFailed(errorMsg: $errorMsg)';
}
