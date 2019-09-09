import 'package:app/domain/usecase/MyInfoUseCase.dart';
import 'package:redux/redux.dart';
import '../../../State.dart';
import 'Reducer.dart';

class UserPresenter extends MiddlewareClass<AppState> {

  final MyInfoUseCase _myInfoUseCase;

  UserPresenter(this._myInfoUseCase);

  @override
  Future call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if(action is GetProfileAction) {
      _myInfoUseCase.run().then((user) {
        store.dispatch(SetProfileData(user.name, user.picURL, user.bio));
      }).catchError((e) {
        print(e);
      });
    } else {
      next(action);
    }
  }
}

class GetProfileAction {
  GetProfileAction();
}

