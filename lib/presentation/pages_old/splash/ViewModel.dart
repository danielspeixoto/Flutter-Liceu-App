import 'package:app/presentation/state/app_state.dart';
import 'package:redux/redux.dart';
class SplashViewModel {
  SplashViewModel();

  factory SplashViewModel.create(Store<AppState> store) {
    return SplashViewModel();
  }
}
