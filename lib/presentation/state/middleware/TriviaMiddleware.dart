import 'package:app/domain/boundary/TriviaBoundary.dart';
import 'package:app/presentation/app.dart';
import 'package:app/presentation/state/actions/TriviaActions.dart';
import 'package:app/presentation/state/navigator/NavigatorActions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:redux/redux.dart';
import '../app_state.dart';

final analytics = FirebaseAnalytics();

List<Middleware<AppState>> triviaMiddleware(
    ICreateTriviaUseCase createTriviaUseCase) {
  void createTrivia(Store<AppState> store, SubmitTriviaAction action,
      NextDispatcher next) async {
    next(action);
    try {
      await createTriviaUseCase.run(
          action.question,
          action.correctAnswer,
          action.wrongAnswer,
          [action.domain]);
      store.dispatch(SubmitTriviaSuccessAction());
    } catch (e) {
      print(e);
    }
  }

  void navigateTrivia(Store<AppState> store, NavigateCreateTriviaAction action,
      NextDispatcher next){
            next(action);
    if (store.state.route.last != AppRoutes.createTrivia) {
      store.dispatch(NavigatePushAction(AppRoutes.createTrivia));
    }
  }

  return [
    TypedMiddleware<AppState, SubmitTriviaAction>(createTrivia),
    TypedMiddleware<AppState, NavigateCreateTriviaAction>(navigateTrivia)
  ];
}
