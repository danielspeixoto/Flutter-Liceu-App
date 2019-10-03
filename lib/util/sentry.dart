import 'dart:io';
import 'package:sentry/sentry.dart';
import '../injection.dart';
import 'package:yaml/yaml.dart';
import 'dart:async';


class Sentry {

  final SentryClient client = new SentryClient(
      dsn: "https://2173bb44d75b4617b22e11ddcd4b9345@sentry.io/1760063",
      environmentAttributes: Event(release: "3.0.15"),);

  Future<void> _reportError(dynamic error, dynamic action, dynamic stackTrace) async {
  print('Caught error: $error');

  final Event event = new Event(
      exception: error,
      stackTrace: stackTrace,
      environment: enviroment,
      level: SeverityLevel.error,
      message: action.toString().substring(11));
      client.capture(event: event);
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
