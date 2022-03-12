part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSucceed extends LoginState {
  final AppUser appUser;
  LoginSucceed({
    required this.appUser,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginSucceed && other.appUser == appUser;
  }

  @override
  int get hashCode => appUser.hashCode;

  @override
  String toString() => 'LoginSucceed(appUser: $appUser)';
}

class LoginFailed extends LoginState {
  final String errorMsg;
  LoginFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'LoginFailed(errorMsg: $errorMsg)';
}
