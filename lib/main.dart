import 'package:app/presentation/app.dart';
import 'package:flutter/material.dart';
import 'package:sentry/sentry.dart';
import 'dart:async';
import 'dart:io';

final SentryClient _sentry = SentryClient(
    dsn: "https://2173bb44d75b4617b22e11ddcd4b9345@sentry.io/1760063");


Future<void> _reportError(dynamic error, dynamic stackTrace) async {

  print('Caught error: $error');

  _sentry.captureException(
    exception: error,
    stackTrace: stackTrace,
  );
}

Future<Null> main() async {
  FlutterError.onError = (FlutterErrorDetails details) async {
      Zone.current.handleUncaughtError(details.exception, details.stack);
  };

  runZoned<Future<Null>>(() async {
    runApp(new MyApp());
  }, onError: (error, stackTrace) async {
    await _reportError(error, stackTrace);

    exit(0);
  });
}




