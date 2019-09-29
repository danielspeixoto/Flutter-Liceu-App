import 'package:app/domain/aggregates/Trivia.dart';
import 'package:app/domain/aggregates/exceptions/CreateTriviaExceptions.dart';
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
      List<TriviaDomain> listDomain;

      if(action.domain == null){
        listDomain = [];
      } else {
        listDomain = [action.domain];
      }
      await createTriviaUseCase.run(
          action.question,
          action.correctAnswer,
          action.wrongAnswer,
          listDomain);
      store.dispatch(SubmitTriviaSuccessAction());
    } on CreateTriviaTagNullException catch (e) {
      store.dispatch(SubmitTriviaErrorTagNullAction());
    } on CreateTriviaQuestionBoundaryException catch (e) {
      store.dispatch(SubmitTriviaErrorQuestionSizeMismatchAction());
    } on CreateTriviaCorrectAnswerBoundaryException catch (e) {
      store.dispatch(SubmitTriviaErrorCorrectAnswerSizeMismatchAction());
    } on CreateTriviaWrongAnswerBoundaryException catch (e) {
      store.dispatch(SubmitTriviaErrorWrongAnswerSizeMismatchAction());
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
