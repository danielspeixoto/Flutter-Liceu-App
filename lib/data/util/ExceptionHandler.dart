import 'package:app/domain/exceptions/AuthenticationException.dart';
import 'package:app/domain/exceptions/ItemNotFoundException.dart';
import 'package:app/domain/exceptions/RequestException.dart';
import 'package:app/presentation/state/actions/UtilActions.dart';
import 'package:app/presentation/state/app_state.dart';

Exception handleNetworkException(int statusCode, String className) {
  switch (statusCode) {
    case 400:
      store.dispatch(OnThrowDataExceptionAction(FormatException(), className));
      return FormatException();
    case 401:
      store.dispatch(OnThrowDataExceptionAction(AuthenticationException(), className));
      return AuthenticationException();
    case 404:
      store.dispatch(OnThrowDataExceptionAction(ItemNotFoundException(), className));
      return ItemNotFoundException();
  }
  store.dispatch(OnThrowDataExceptionAction(RequestException(), className));
  return new RequestException();
}
