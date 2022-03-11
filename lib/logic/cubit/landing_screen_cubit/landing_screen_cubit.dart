import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'landing_screen_state.dart';

class LandingScreenCubit extends Cubit<LandingScreenState> {
  LandingScreenCubit() : super(LandingScreenInitial());
}
