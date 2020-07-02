import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  Future<void> delay([int milliseconds = 250]) async {
    await Future<void>.delayed(Duration(milliseconds: milliseconds));
  }

  // Initial test to check health sttus of Flutter Driver
  test('check flutter driver health', () async {
    final health = await driver.checkHealth();
    expect(health.status, HealthStatus.ok);
  });

  // Does not work at the moment
  test('log in and log out', () async {
    final signinButton = find.byValueKey('login');
    await driver.waitFor(signinButton);
    await delay(750);
    await driver.tap(signinButton);

    // if (auth == true){

    /*
    final logoutButton = find.byValueKey('logout');
    final popMenu = find.byValueKey('popMenu');
    await driver.waitFor(popMenu);
    await delay(750);
    await driver.tap(popMenu);
    await driver.waitFor(logoutButton);
    await delay(750);
    await driver.tap(logoutButton);

    await driver.waitFor(signinButton);
    */
    // }
    // else{
    //   login failer;
    // }
  });
}
