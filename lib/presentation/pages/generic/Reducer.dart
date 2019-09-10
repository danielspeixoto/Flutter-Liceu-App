import 'package:redux/redux.dart';

class GenericPageState {
  GenericPageState();

  factory GenericPageState.initial() => GenericPageState();
}

final Reducer<GenericPageState> genericPageReducer = combineReducers<GenericPageState>([
]);

class GenericPageIsLoading {
  GenericPageIsLoading();
}

GenericPageState pageIsLoading(GenericPageState state, GenericPageIsLoading action) {
  return GenericPageState();
}