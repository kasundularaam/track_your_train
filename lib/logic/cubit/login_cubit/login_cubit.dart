import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/enums/user_type.dart';
import '../../../data/checker/ticket_checker_checker.dart';
import '../../../data/firebase/fire_auth.dart';
import '../../../data/models/type_user.dart';
import '../../../data/validator/data_validator.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    try {
      emit(LoginLoading());

      final bool validatedLogin =
          DataValidator.validateLogin(email: email, password: password);
      if (validatedLogin) {
        TypeUser typeUser =
            await getUserTypeData(email: email, password: password);
        emit(LoginSucceed(typeUser: typeUser));
      }
    } catch (e) {
      emit(LoginFailed(errorMsg: e.toString()));
      emit(LoginInitial());
    }
  }

  Future<TypeUser> getUserTypeData(
      {required String email, required String password}) async {
    try {
      final bool isTicketChecker = TicketCheckerChecker.isTicketChecker(
          email: email, password: password);

      if (isTicketChecker) {
        return TypeUser(
          email: email,
          uid: TicketCheckerChecker.uid,
          userType: UserType.ticketChecker,
        );
      }

      TypeUser fireUser = await FireAuth.getTypeUser(uid: FireAuth.uid);
      return fireUser;
    } catch (e) {
      throw e.toString();
    }
  }
}
