#  Prosjekt Ombruk mobile app

This is a Flutter project for [Renovasjons- og gjenvinningsetaten (*REG*)](https://www.oslo.kommune.no/etater-foretak-og-ombud/renovasjons-og-gjenvinningsetaten/) in Oslo kommune.

## Getting Started
If you are unfamiliar with Flutter, then go to [the Flutter website](https://flutter.dev) for information on how to get started.    
For environment setup on macOS, see `macOS.md`.

## Project structure
The application works as three different applications on its own, one for each role/person who uses the app:
* Partner
* Station
* REG employee

The different screens are based on which role you are logged in as.

Each role has some seperate Flutter components and widgets, for example the `RegComponents` folder. Shared widgets are placed outside these folders.

### Login and roles

The login/authentication solution is based on [Keycloak](https://www.keycloak.org). All three roles uses this shared solution, and the ```AuthRouter.dart``` is responsible for displaying the correct ```TabsScreen```:
* ```TabsScreenPartner.dart```
* ```TabsScreenStasjon.dart```
* ```TabsScreenReg.dart```

The login credentials are stored in `UserViewModel.dart`, and all authorization goes through that file and `AuthorizationService.dart`, as well as `LoginWebView.dart` for Keycloak login.



### Third-party libraries
* [get_it](https://pub.dev/packages/get_it) - Service locator which makes it possible to define one instance (a singleton) of our Authentication API for example.
* [Provider](https://pub.dev/packages/provider) - See below
* [flutter_week_view](https://pub.dev/packages/flutter_week_view) - The pretty calendar
* [grouped-list](https://pub.dev/packages/grouped_list) - Puts date-text dividers between the vertical calendar`s days
* [openid_client](https://pub.dev/packages/openid_client) - Used to open the Keycloak login website
* [url_launcher](https://pub.dev/packages/url_launcher) - Provides the Keycloak authorization logic
* [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) - Stores the user login information (access token, refresh token, roles, name etc.)
* [intl](https://pub.dev/packages/intl) - Used for `DateFormat(...).format` in `DayScroller.dart`

### Provider and state management

This app uses the [Provider](https://pub.dev/packages/provider) library to make the API services and some of the app states available globally or where it is needed. For example, we want our Authentication API and logged-in user information to be available everywhere in the app. If you are unfamiliar with the pattern, then you can read about it in the [official docs](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple) or in [this tutorial](https://www.raywenderlich.com/6373413-state-management-with-provider). The tutorial also covers some MVVM architecture in which the app is built upon.

## Further development
First of all, there is a bug in the service/view model scheme. When app is loaded for the first time, the services aren't correctly getting the desired `UserViewModel`, so the Authorization header's token is not correctly set. The cause for this is that the `UserViewModel` is not registered as a singleton in `serviceLocator.dart`. Furthermore, when this bug is fixes, the `_updateTokenInHeader()` function in most services should be removed. This bug was discovered pretty late, so we did not have time to fix it :( but good luck!

### Further development keypoints:

* Weight reporting should only show the logged in station/partners events.
* All custom icons should be added as .ttf files instead of .png files.
* The login page should be styled and the splash screen is pretty basic right now.
* The user should be able to swipe the vetical day scroller (`DayScroller.dart`) on the entire screen, and not only in its row.
* The user should be asked to login again if the access token and refresh token is not valid anymore. At the moment, this is not handled properly.