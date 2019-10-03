import 'dart:io';
import 'package:sentry/sentry.dart';
import '../injection.dart';
import 'package:yaml/yaml.dart';
import 'dart:async';


class Sentry {

  final SentryClient client = new SentryClient(
      dsn: "https://2173bb44d75b4617b22e11ddcd4b9345@sentry.io/1760063",
      environmentAttributes: Event(release: "3.0.15"),);

  Future<void> reportError(dynamic error, dynamic stackTrace) async {
    // Print the exception to the console.
    print('Caught error: $error');
    if (isDev) {
      // Print the full stacktrace in debug mode.
      print(stackTrace);
      return;
    } else {
      // Send the Exception and Stacktrace to Sentry in Production mode.
      await client.captureException(
        exception: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<String> getRelease() async {
    File pubspec = new File("../pubspec.yaml");
    final text = await pubspec.readAsString();
    Map yaml = loadYaml(text);

    return yaml['version'];

  }

  Future<void> log(dynamic action) async {
    if (!isDev) {
      await client.capture(event: action);
    }
  }
}
