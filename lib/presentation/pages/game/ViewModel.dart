import 'package:app/presentation/aggregates/ChallengeData.dart';
import 'package:app/presentation/redux/app_state.dart';
import 'package:app/presentation/redux/reducers/Data.dart';
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
