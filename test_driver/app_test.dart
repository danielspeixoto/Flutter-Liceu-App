// Imports the Flutter Driver API.
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Liceu', () {
    final skipIntroFinder = find.byValueKey('skipIntro');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      await Process.run('applesimutils', [
        "--booted YES",
        "--clearKeychain",
        "--bundle com.deffish",
        "--setPermissions",
        "notifications=YES"
      ]);
      driver = await FlutterDriver.connect();
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
