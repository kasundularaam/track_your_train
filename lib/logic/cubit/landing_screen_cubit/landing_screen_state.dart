part of 'landing_screen_cubit.dart';

@immutable
abstract class LandingScreenState {}

class LandingScreenInitial extends LandingScreenState {}

class LandingScreenLoading extends LandingScreenState {}

class LandingScreenSucceed extends LandingScreenState {
  final TypeUser typeUser;
  LandingScreenSucceed({
    required this.typeUser,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LandingScreenSucceed && other.typeUser == typeUser;
  }

  @override
  int get hashCode => typeUser.hashCode;

  @override
  String toString() => 'LandingScreenSucceed(typeUser: $typeUser)';
}

class LandingScreenNoUser extends LandingScreenState {}

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
