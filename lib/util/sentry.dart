import 'dart:io';
import 'package:sentry/sentry.dart';
import '../injection.dart';
import 'package:yaml/yaml.dart';
import 'dart:async';

class Sentry {
  final SentryClient client = new SentryClient(
    dsn: "https://2173bb44d75b4617b22e11ddcd4b9345@sentry.io/1760063",
    environmentAttributes: Event(release: "3.0.15"),
  );

  Future<void> reportError(
      dynamic error, String message, dynamic stackTrace, [dynamic parameters]) async {

    final Event event = new Event(
        exception: error,
        stackTrace: stackTrace,
        environment: enviroment,
        level: SeverityLevel.error,
        extra: parameters,
        message: "Exception in " + message);
    client.capture(event: event);
  }

  Future<void> setUserContext(String id, String name) async {

    client.userContext = User(id: id, username: name);
  }

  Future<void> reportInfo(dynamic action) async {
    //if (!isDev) {
      final Event event = new Event(
          environment: enviroment,
          level: SeverityLevel.info,
          message: action.toString().substring(11));
      client.capture(event: event);
    //}
  }

  Future<String> getRelease() async {
    File pubspec = new File("../pubspec.yaml");
    final text = await pubspec.readAsString();
    Map yaml = loadYaml(text);

    return yaml['version'];
  }
}
