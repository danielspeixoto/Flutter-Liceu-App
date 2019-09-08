import 'package:app/presentation/login/Presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'Injection.dart';
import 'State.dart';
import 'presentation/login/View.dart';
import 'package:redux_logging/redux_logging.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Store<AppState> store = Store<AppState>(appReducer,
      /* Function defined in the reducers file */
      initialState: AppState.initial(),
      middleware: [new LoggingMiddleware.printer(), LoginPresenter(loginUseCase)]);

  @override
  Widget build(BuildContext context) => StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Liceu',
        theme: ThemeData(primaryColorDark: new Color(0xFF0061A1)),
        home: LoginPage(),
      ));
}
