import 'package:logger/logger.dart';
import 'package:redux/redux.dart';
import '../app_state.dart';

class ActionLoggingMiddleware extends MiddlewareClass<AppState> {
  ActionLoggingMiddleware();

  @override
  Future call(
      Store<AppState> store, dynamic action, NextDispatcher next) async {

    final logger = Logger(
        printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 70,
      colors: true,
      printEmojis: true,
      printTime: true,
    ));
    logger.d("Executing Action: ${action.toString().substring(11)}");

    //logger.log(Level.info, "Executing Action: ${action.toString().substring(11)}");

    next(action);
  }
}
