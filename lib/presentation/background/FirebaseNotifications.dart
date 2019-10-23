import 'dart:io';

import 'package:app/presentation/state/actions/FriendActions.dart';
import 'package:app/presentation/state/actions/NotificationActions.dart';
import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/actions/UserActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:redux/redux.dart';
import 'package:uni_links/uni_links.dart';

class ExternalConnections {
  FirebaseMessaging _firebaseMessaging;
  final Store<AppState> store;

  ExternalConnections(this.store) {
    this._firebaseMessaging = FirebaseMessaging();
    if (Platform.isIOS) iOSPermission();

    _firebaseMessaging.getToken().then((token) {
      store.dispatch(SetUserFcmTokenAction(token));
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on notification message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        try {
          store.dispatch(NotificationResumesApp(
            message["data"]["action"],
            message["data"] as Map,
          ));
        } catch (e) {
          print(e);
        }
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("on launch");
        try {
          store.dispatch(
            NotificationLaunchesApp(
              message["data"]["action"],
              message["data"] as Map,
            ),
          );
        } catch (e) {
          print(e);
        }
      },
    );
    link(store);
  }

  void link(Store<AppState> store) async {
    try {
      final initialLink = await getInitialUri();
      print(initialLink);
      if (initialLink != null) {
        final userId = initialLink.queryParameters['userId'];
        final postId = initialLink.queryParameters['postId'];

        if (userId != null) {
          Future.delayed(Duration(seconds: 3), () {
            store.dispatch(NavigateViewFriendAction());
            store.dispatch(FetchFriendAction(userId));
            store.dispatch(FetchFriendPostsAction(userId));
          });
        } else if(postId != null) {
          Future.delayed(Duration(seconds: 3), () {
            store.dispatch(FetchPostFromNotificationAction(postId));
          });
        }
      }
    } on PlatformException {}
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
