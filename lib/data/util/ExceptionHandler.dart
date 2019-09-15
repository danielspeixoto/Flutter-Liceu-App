import 'package:app/domain/exceptions/AuthenticationException.dart';
import 'package:app/domain/exceptions/ItemNotFoundException.dart';
import 'package:app/domain/exceptions/RequestException.dart';

Exception handleNetworkException(int statusCode) {
  switch (statusCode) {
    case 400:
      return FormatException();
    case 401:
      return AuthenticationException();
    case 404:
      return ItemNotFoundException();
  }
  return new RequestException();
}
