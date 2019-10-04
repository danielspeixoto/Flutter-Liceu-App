import 'package:facebook_analytics_plugin/facebook_analytics_plugin.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class LiceuAnalytics {
  static final _analytics = FirebaseAnalytics();

  static logEvent(String eventName, [Map<String, dynamic> params]) {
    _analytics.logEvent(name: eventName, parameters: params);
    FacebookAnalyticsPlugin.logCustomEvent(name: eventName, parameters: params);
  }

  static void setCurrentScreen(String screenName) {
    _analytics.setCurrentScreen(screenName: screenName);
  }

  static void logShare({String contentType, String itemId, String method}) {
    _analytics.logShare(
        contentType: contentType, itemId: itemId, method: method);
    FacebookAnalyticsPlugin.logCustomEvent(name: "share");
  }

  static void logLogin({String loginMethod}) {
    _analytics.logLogin(loginMethod: loginMethod);
    FacebookAnalyticsPlugin.logCustomEvent(
        name: "login", parameters: {"method": loginMethod});
  }

  static void setUserProperty(String name, String value) {
    _analytics.setUserProperty(name: name, value: value);
  }
}
