import 'package:app/injection.dart';
import 'package:redux/redux.dart';

class FeatureState {
  final bool viewFriend;
  final bool createTrivia;
  final bool reportQuestion;
  final bool reportSidemenu;
  final bool reportLogin;

  FeatureState(this.viewFriend, this.createTrivia, this.reportQuestion,
      this.reportSidemenu, this.reportLogin);

  factory FeatureState.initial() =>
      FeatureState(true, true, true, true, Feature.isDev);

  FeatureState copyWith(
      {bool viewFriend,
      bool createTrivia,
      bool reportQuestion,
      bool reportSidemenu,
      bool reportLogin}) {
    final state = FeatureState(
        viewFriend ?? this.viewFriend,
        createTrivia ?? this.createTrivia,
        reportQuestion ?? this.reportQuestion,
        reportSidemenu ?? this.reportSidemenu,
        reportLogin ?? this.reportLogin);
    return state;
  }
}

final Reducer<FeatureState> featureReducer = combineReducers<FeatureState>([

]);
