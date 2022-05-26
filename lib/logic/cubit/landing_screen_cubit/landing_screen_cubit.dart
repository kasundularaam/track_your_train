import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/enums/user_type.dart';
import '../../../data/firebase/fire_auth.dart';
import '../../../data/models/app_user.dart';
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
        log(typeUser.toString());
        if (typeUser.userType == UserType.user) {
          final AppUser user = await FireAuth.getUserData();
          emit(LandingScreenUser(user: user));
        }
        if (typeUser.userType == UserType.driver) {
          final AppUser user = await FireAuth.getUserData();
          emit(LandingScreenTrain(user: user));
        }
        if (typeUser.userType == UserType.ticketChecker) {
          emit(LandingScreenTicketChecker(user: typeUser));
        }
      }
      if (!signed) {
        emit(LandingScreenToAuth());
      }
    } catch (e) {
      emit(LandingScreenFailed(errorMsg: e.toString()));
    }
  }
}
