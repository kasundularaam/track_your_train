import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/type_user.dart';
import '../../../data/shared/shared_auth.dart';
part 'landing_screen_state.dart';

class LandingScreenCubit extends Cubit<LandingScreenState> {
  LandingScreenCubit() : super(LandingScreenInitial());

  Future<void> startApp() async {
    try {
      emit(LandingScreenLoading());
      await Future.delayed(const Duration(seconds: 2));
      bool signed = await SharedAuth.signed();
      if (signed) {
        TypeUser typeUser = await SharedAuth.getUser();
        emit(LandingScreenSucceed(typeUser: typeUser));
      } else {
        emit(LandingScreenNoUser());
      }
    } catch (e) {
      emit(LandingScreenFailed(errorMsg: e.toString()));
    }
  }
}
