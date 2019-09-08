import 'package:redux/redux.dart';

class HomePageState {
  HomePageState();

  factory HomePageState.initial() => HomePageState();
}

final Reducer<HomePageState> HomePageReducer = combineReducers<HomePageState>([
]);

class HomePageIsLoading {
  HomePageIsLoading();
}

HomePageState pageIsLoading(HomePageState state, HomePageIsLoading action) {
  return HomePageState();
}