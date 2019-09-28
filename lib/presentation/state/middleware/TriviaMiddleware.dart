import 'package:app/domain/boundary/TriviaBoundary.dart';
import 'package:app/presentation/state/actions/TriviaActions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:redux/redux.dart';
import '../app_state.dart';

final analytics = FirebaseAnalytics();

List<Middleware<AppState>> triviaMiddleware(
    ICreateTriviaUseCase createTriviaUseCase) {
      
  void createTrivia(Store<AppState> store, CreateTriviaAction action,
      NextDispatcher next) async {
    next(action);
    try {
      await createTriviaUseCase.run(
          action.question,
          action.correctAnswer,
          action.wrongAnswer,
          [action.domain]);
    } catch (e) {
      print(e);
    }
  }

  return [
    TypedMiddleware<AppState, CreateTriviaAction>(createTrivia)
  ];
}
