import 'package:app/presentation/app.dart';
import 'package:app/util/StackFilter.dart';
import 'package:app/util/sentry.dart';
import 'package:flutter/material.dart';
import 'package:sentry/sentry.dart';
import 'package:app/injection.dart';
import 'dart:async';
import 'dart:io';

final sentry = Sentry();

Future<void> _reportError(dynamic error, dynamic stackTrace) async {
  print('Caught error: $error');

  final Event event = new Event(
      exception: error,
      stackTrace: stackTrace,
      environment: enviroment,
      level: SeverityLevel.error);
  await sentry.client.capture(event: event);

  if(!isDev){
    exit(0);
  }
}

Future<Null> main() async {
  FlutterError.onError = (FlutterErrorDetails details) async {
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };

  

  runZoned<Future<Null>>(() async {
    runApp(new MyApp());
  }, onError: (error, stackTrace) async {
    
    await _reportError(error, filter(stackTrace));
  });
}
