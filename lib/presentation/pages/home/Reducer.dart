import 'package:redux/redux.dart';

class HomePageState {

  final bool isLoading;

  HomePageState(this.isLoading);

  factory HomePageState.initial() => HomePageState(true);
}

final Reducer<HomePageState> homePageReducer = combineReducers<HomePageState>([
]);

class HomePageIsLoading {
  final bool isLoading;
  HomePageIsLoading(this.isLoading);
}

HomePageState homePageIsLoading(HomePageState state, HomePageIsLoading action) {
  return HomePageState(action.isLoading);
}