// Imports the Flutter Driver API.
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Liceu', () {
    FlutterDriver driver;
    final skipIntroFinder = find.byValueKey('skipIntro');
    setUpAll(() async {
      await Process.run("adb", [
        'shell',
        'pm',
        'grant',
        'com.deffish',
        'android.permission.READ_EXTERNAL_STORAGE'
      ]);
      await Process.run("adb", [
        'shell',
        'pm',
        'grant',
        'com.deffish',
        'android.permission.ACCESS_NOTIFICATION_POLICY'
      ]);
      driver = await FlutterDriver.connect();
      sleep(Duration(seconds: 30));
      await driver.waitFor(skipIntroFinder);
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('User can login', () async {
      await driver.tap(skipIntroFinder);

      final facebookLoginFinder = find.byValueKey("facebookLogin");
      await driver.tap(facebookLoginFinder);
      await driver.waitForAbsent(facebookLoginFinder);
      find.byValueKey("homePage");
    });
  });
}
