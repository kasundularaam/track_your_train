import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:track_your_train/data/firebase/fire_auth.dart';
import 'package:track_your_train/data/shared/shared_auth.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  SignOutCubit() : super(SignOutInitial());

  Future<void> signOut() async {
    try {
      emit(SignOutLoading());
      await FireAuth.signOut();
      await SharedAuth.clearData();
      emit(SignOutSucceed());
    } catch (e) {
      emit(SignOutFailed(errorMsg: e.toString()));
      emit(SignOutInitial());
    }
  }
}
