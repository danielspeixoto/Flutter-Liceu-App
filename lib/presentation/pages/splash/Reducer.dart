import 'package:redux/redux.dart';

class SplashPageState {
  SplashPageState();

  factory SplashPageState.initial() => SplashPageState();
}

final Reducer<SplashPageState> SplashPageReducer = combineReducers<SplashPageState>([
]);

class SplashPageIsLoading {
  SplashPageIsLoading();
}

SplashPageState pageIsLoading(SplashPageState state, SplashPageIsLoading action) {
  return SplashPageState();
}