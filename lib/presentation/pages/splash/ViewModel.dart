import 'package:app/presentation/navigator/NavigatorActions.dart';
import 'package:redux/redux.dart';
import '../../../State.dart';
import '../../../main.dart';
import 'Presenter.dart';

class SplashViewModel {
  SplashViewModel();
  factory SplashViewModel.create(Store<AppState> store) {
    return SplashViewModel();
  }
}
