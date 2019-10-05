import 'package:app/presentation/state/actions/UtilActions.dart';
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
  void logPresentationError(Store<AppState> store,
      OnCatchDefaultErrorAction action, NextDispatcher next) async {
    logger.e("Error in Action: ${action.message}");
    next(action);
  }

  void logInfo(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (!(action is OnCatchDefaultErrorAction)) {
      logger.i("Executing Action: ${action.toString().substring(11)}");
    }
    next(action);
  }

  void logDataError(Store<AppState> store, OnThrowDataExceptionAction action,
      NextDispatcher next) async {
    logger.wtf("${action.exception} in method ${action.className}");
    next(action);
  }

  return [
    TypedMiddleware<AppState, OnCatchDefaultErrorAction>(logPresentationError),
    TypedMiddleware<AppState, OnThrowDataExceptionAction>(logDataError),
    TypedMiddleware<AppState, dynamic>(logInfo),
  ];
}
