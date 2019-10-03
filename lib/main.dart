import 'package:app/presentation/app.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/util/sentry.dart';
import 'package:flutter/material.dart';
import 'package:sentry/sentry.dart';
import 'package:app/injection.dart';
import 'dart:async';

final sentry = Sentry();

Future<void> _reportError(dynamic error, dynamic stackTrace) async {
  print('Caught error: $error');

  final Event event = new Event(
      exception: error,
      stackTrace: stackTrace,
      environment: enviroment,
      level: SeverityLevel.error);
  sentry.client.capture(event: event);
}

Future<Null> main() async {
  FlutterError.onError = (FlutterErrorDetails details) async {
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };

  runZoned<Future<Null>>(() async {
    runApp(new MyApp());
  }, onError: (error, stackTrace) async {
    store.dispatch(action);
  });
}
