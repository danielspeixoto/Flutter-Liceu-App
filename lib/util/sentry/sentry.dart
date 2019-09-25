import 'package:sentry/sentry.dart';
import '../../injection.dart';

class Sentry {
  final SentryClient sentry = new SentryClient(dsn: "https://2173bb44d75b4617b22e11ddcd4b9345@sentry.io/1760063");

  bool get isInDevelopmentMode {

    if(baseURL.contains('liceu-staging')){
      return true;
    }

    return false;
  }

  Future<void> reportError(dynamic error, dynamic stackTrace) async {
    // Print the exception to the console.
    print('Caught error: $error');
    if (isInDevelopmentMode) {
      // Print the full stacktrace in debug mode.
      print(stackTrace);
      return;
    } else {
      // Send the Exception and Stacktrace to Sentry in Production mode.
      await sentry.captureException(
        exception: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> log(dynamic action) async {
    if (!isInDevelopmentMode) {
      await sentry.capture(event: action);
    }
  }
}



