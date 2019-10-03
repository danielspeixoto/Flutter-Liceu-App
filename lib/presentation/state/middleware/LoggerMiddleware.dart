import 'package:app/presentation/state/actions/LoggerActions.dart';
import 'package:logger/logger.dart';
import 'package:redux/redux.dart';
import '../app_state.dart';

final logger = Logger(
    printer: PrettyPrinter(
  methodCount: 0,
  errorMethodCount: 5,
  lineLength: 70,
  colors: true,
  printEmojis: true,
  printTime: true,
));

List<Middleware<AppState>> loggerMiddleware() {
  void logError(
      Store<AppState> store, LoggerErrorAction action, NextDispatcher next) {
    logger.e("Error in Action: ${action.actionName}");
    next(action);
  }

  void logInfo(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (!(action is LoggerErrorAction)) {
      logger.i("Executing Action: ${action.toString().substring(11)}");
      next(action);
    }
  }

  return [
    TypedMiddleware<AppState, LoggerErrorAction>(logError),
    TypedMiddleware<AppState, dynamic>(logInfo),
  ];
}
