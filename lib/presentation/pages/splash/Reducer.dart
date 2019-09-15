import 'package:redux/redux.dart';

class SplashPageState {
  SplashPageState();

  factory SplashPageState.initial() => SplashPageState();
}

final Reducer<SplashPageState> splashPageReducer =
    combineReducers<SplashPageState>([]);

class SplashPageIsLoading {
  SplashPageIsLoading();
}

SplashPageState pageIsLoading(
    SplashPageState state, SplashPageIsLoading action) {
  return SplashPageState();
}
