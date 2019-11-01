import 'package:app/presentation/state/actions/LoginActions.dart';
import 'package:redux/redux.dart';
import 'package:app/presentation/state/app_state.dart';

class IntroViewModel {
  final Function() onDoneOrSkipButtonPressed;


  IntroViewModel({this.onDoneOrSkipButtonPressed});

  factory IntroViewModel.create(Store<AppState> store) {
    return IntroViewModel(
      onDoneOrSkipButtonPressed: () => store.dispatch(NavigateLoginAction())
    );
  }
}