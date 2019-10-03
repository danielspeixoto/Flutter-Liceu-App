
import 'package:redux/redux.dart';
import '../app_state.dart';
import '../../../util/sentry/sentry.dart';

final logging = Sentry();

List<Middleware<AppState>> sentryMiddleware() {
  return [];
}
