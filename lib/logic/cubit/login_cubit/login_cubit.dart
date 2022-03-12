import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:track_your_train/data/http/http_services.dart';
import 'package:track_your_train/data/models/app_user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    try {
      emit(
        LoginLoading(),
      );
      await HTTPServices.loginUser(
        email: email,
        password: password,
      );
      emit(
        LoginSucceed(appUser: AppUser(email: "email", isUser: false)),
      );
    } catch (e) {
      emit(
        LoginFailed(
          errorMsg: e.toString(),
        ),
      );
      emit(
        LoginInitial(),
      );
    }
  }
}
