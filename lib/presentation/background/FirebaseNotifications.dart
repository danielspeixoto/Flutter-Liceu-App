import 'dart:io';

import 'package:app/presentation/state/app_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:redux/redux.dart';

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
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
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