#  Prosjekt Ombruk mobile app

This is a project for [Renovasjons- og gjenvinningsetaten (*REG*)](https://www.oslo.kommune.no/etater-foretak-og-ombud/renovasjons-og-gjenvinningsetaten/) in Oslo kommune.

## Getting Started
If you are unfamiliar with Flutter, then go to [the Flutter website](https://flutter.dev) for information on how to get started.

## Project structure
The application works as three different applications on its own, one for each role in REG:
* Partner
* Station
* REG employee

## Login and roles

The login/authentication solution is based on [Keycloak](https://www.keycloak.org). All three roles uses this shared solution, and the ```AuthRouter.dart``` is responsible for displaying the correct ```TabsScreen```:
* ```TabsScreenPartner.dart```
* ```TabsScreenStasjon.dart```
* ```TabsScreenReg.dart```



## Third-party libraries
* [get_it](https://pub.dev/packages/get_it) - Service locator which makes it possible to define one instance (a singleton) of our Authentication API for example.
* [Provider](https://pub.dev/packages/provider) - See below
* [flutter_week_view](https://pub.dev/packages/flutter_week_view) - The pretty calendar
* [grouped-list](https://pub.dev/packages/grouped_list) - Puts date-text dividers between the vertical calendar`s days
* [openid_client](https://pub.dev/packages/openid_client) - Used to open the Keycloak login website
* [url_launcher](https://pub.dev/packages/url_launcher) - Provides the Keycloak authorization logic
* [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) - Stores the user login information (access token, refresh token, roles, name etc.)
* [intl](https://pub.dev/packages/intl) - Used for `DateFormat(...).format` in `DayScroller.dart`

### Provider and state management

This app uses the [Provider](https://pub.dev/packages/provider) library to make data/props available globally or where it is needed. For example, we want our Authentication API and logged-in user information to be available everywhere in the app. If you are unfamiliar with the pattern, then you can read about it in the [official docs](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple) or in [this tutorial](https://www.raywenderlich.com/6373413-state-management-with-provider). The tutorial also covers some MVVM architecture in which the app is built upon. 