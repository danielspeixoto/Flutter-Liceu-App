import 'package:app/domain/aggregates/Trivia.dart';
import 'package:app/domain/aggregates/exceptions/CreateTriviaExceptions.dart';
import 'package:app/domain/boundary/TriviaBoundary.dart';
import 'package:app/presentation/app.dart';
import 'package:app/presentation/state/actions/UtilActions.dart';
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
    } on DomainException catch (e) {
      store.dispatch(SubmitTriviaErrorTagNullAction(action.question,
          action.correctAnswer,
          action.wrongAnswer));
    } on QuestionException catch (e) {
      store.dispatch(SubmitTriviaErrorQuestionSizeMismatchAction(action.question,
          action.correctAnswer,
          action.wrongAnswer,));
    } on CorrectAnswerException catch (e) {
      store.dispatch(SubmitTriviaErrorCorrectAnswerSizeMismatchAction(action.question,
          action.correctAnswer,
          action.wrongAnswer,));
    } on WrongAnswerException catch (e) {
      store.dispatch(SubmitTriviaErrorWrongAnswerSizeMismatchAction(action.question,
          action.correctAnswer,
          action.wrongAnswer,));
    } catch (error, stackTrace) {
                 final actionName = action.toString().substring(11);
      store.dispatch(OnCatchDefaultErrorAction(
          error.toString(), stackTrace, actionName, action.itemToJson()));
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
