import 'package:app/presentation/state/actions/TriviaActions.dart';
import 'package:redux/redux.dart';

class TriviaState {
  final bool isLoading;

  TriviaState({this.isLoading: true});

  factory TriviaState.initial() => TriviaState();

  TriviaState copyWith({bool isLoading}) {
    final state = TriviaState(
      isLoading: isLoading ?? this.isLoading,
    );
    return state;
  }
}

final Reducer<TriviaState> triviaReducer =
    combineReducers<TriviaState>([
  TypedReducer<TriviaState, CreateTriviaAction>(createTrivia),
  TypedReducer<TriviaState, TriviaCreatedAction>(triviaCreated)
]);

TriviaState createTrivia(
    TriviaState state, CreateTriviaAction action) {
  return state.copyWith(isLoading: true);
}

TriviaState triviaCreated(TriviaState state, TriviaCreatedAction action) {
  return state.copyWith(isLoading: false);
}
