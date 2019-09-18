import 'package:app/presentation/state/aggregates/ChallengeData.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/state/reducers/Data.dart';
import 'package:redux/redux.dart';

class GameViewModel {

  final Data<List<ChallengeData>> challenges;

  GameViewModel({this.challenges});

  factory GameViewModel.create(Store<AppState> store) {
    return GameViewModel(
      challenges: store.state.userState.challenges
    );
  }
}
