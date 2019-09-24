import 'package:sentry/sentry.dart';


class Sentry {
  final SentryClient sentry = new SentryClient(dsn: "https://2173bb44d75b4617b22e11ddcd4b9345@sentry.io/1760063");

  bool get isInDevelopmentMode {
    // Assume you're in production mode.
    bool inDevelopmentMode = false;

    // Assert expressions are only evaluated during development. They are ignored
    // in production. Therefore, this code only sets `inDebugMode` to true
    // in a development environment.
    assert(inDevelopmentMode = true);

    return inDevelopmentMode;
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

  Future<void> log(dynamic actionName) async {

    if(isInDevelopmentMode) {

      print('$actionName');

    } else {
      await sentry.capture(event: actionName);
    }
  }
}



