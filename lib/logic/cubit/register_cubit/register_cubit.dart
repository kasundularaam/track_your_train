import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:track_your_train/core/enums/user_type.dart';
import 'package:track_your_train/data/models/app_user.dart';
import 'package:track_your_train/data/models/type_user.dart';

import '../../../data/firebase/fire_auth.dart';
import '../../../data/shared/shared_auth.dart';
import '../../../data/validator/data_validator.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      emit(RegisterLoading());

      final bool validatedRegister = DataValidator.validateRegister(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
      if (validatedRegister) {
        User user =
            await FireAuth.registerUser(email: email, password: password);
        await FireAuth.addNewUser(
          appUser: AppUser(
            userId: user.uid,
            userName: name,
            userEmail: email,
            userType: UserType.user,
          ),
        );
        await SharedAuth.clearData();
        await SharedAuth.addUser(
          typeUser: TypeUser(
            userId: user.uid,
            userEmail: email,
            userType: UserType.user,
          ),
        );
        emit(RegisterSucceed(user: user));
      }
    } catch (e) {
      emit(RegisterFailed(errorMsg: e.toString()));
      emit(RegisterInitial());
    }
  }
}
