import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:track_your_train/data/models/train_details.dart';

part 'train_details_state.dart';

class TrainDetailsCubit extends Cubit<TrainDetailsState> {
  TrainDetailsCubit() : super(TrainDetailsInitial());

  Future<void> getTrainDetails({required String trainId}) async {
    try {} catch (e) {
      emit(TrainDetailsFailed(errorMsg: e.toString()));
    }
  }
}
