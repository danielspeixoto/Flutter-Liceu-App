import 'dart:io';

import 'package:app/presentation/state/actions/ChallengeActions.dart';
import 'package:app/presentation/state/actions/ENEMActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:redux/redux.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  print("background notification handler");
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

class FirebaseNotifications {
  FirebaseMessaging _firebaseMessaging;
  final Store<AppState> store;

  FirebaseNotifications(this.store) {
    this._firebaseMessaging = FirebaseMessaging();
    if (Platform.isIOS) iOSPermission();

    _firebaseMessaging.getToken().then((token) {
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on notification message $message');
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onResume: (Map<String, dynamic> message) async {
        print("notification: on resume");
        if (store.state.loginState.isUserLoggedIn()) {
          if (message["data"]["action"] == "start_challenge") {
            store.dispatch(ChallengeAction());
          }
          if (message["data"]["action"] == "enem_training") {
            store.dispatch(TrainingAction());
          }
          if (message["data"]["action"] == "enem_tournament") {
            store.dispatch(TournamentAction());
          }
        }
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('notification: on launch $message');
        store.dispatch(ChallengeAction());
      },
    );
  }

  void iOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}
