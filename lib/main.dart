import 'dart:async';

import 'package:app/injection.dart';
import 'package:app/presentation/app.dart';
import 'package:app/util/StackFilter.dart';
import 'package:app/util/sentry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crashlytics/flutter_crashlytics.dart';
import 'package:sentry/sentry.dart';

final sentry = Sentry();

Future<void> _reportError(dynamic error, dynamic stackTrace) async {
  print('Caught error: $error');

  final Event event = new Event(
      exception: error,
      stackTrace: stackTrace,
      environment: enviroment,
      level: SeverityLevel.error);
  await sentry.client.capture(event: event);
}

Future<Null> main() async {
  FlutterError.onError = (FlutterErrorDetails details) async {
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };

  await FlutterCrashlytics().initialize();

  runZoned<Future<Null>>(() async {
    runApp(new MyApp());
  }, onError: (error, stackTrace) async {
    await _reportError(error, filter(stackTrace));
    await FlutterCrashlytics()
        .reportCrash(error, stackTrace, forceCrash: false);
  });
}
