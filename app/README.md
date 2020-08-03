#  Prosjekt Ombruk mobile app

This is a project for [Renovasjons- og gjenvinningsetaten (*REG*)](https://www.oslo.kommune.no/etater-foretak-og-ombud/renovasjons-og-gjenvinningsetaten/) in Oslo kommune.

## Getting Started
If you are unfamiliar with Flutter, then go to [the Flutter website](https://flutter.dev) for information on how to get started.

## Project structure
The application works as three different applications on its own, one for each role in REG:
* Partner
* Station
* REG employee

The login/authentication solution is based on [Keycloak](https://www.keycloak.org). All three roles uses this shared solution, and the ```AuthRouter.dart``` is responsible for displaying the correct ```TabsScreen```:
* ```TabsScreenPartner.dart```
* ```TabsScreenStasjon.dart```
* ```TabsScreenReg.dart```

```AuthRouter.dart``` is built with the [Bloc pattern](https://bloclibrary.dev/#/).

## Third-party libraries
* get_it to make the login credentials available globally

### Bloc pattern and state management

**Disclaimer**: This project is not completely built with the Bloc pattern, **only some compoents use it**. The compnents that are built with the Bloc pattern are:
* ```AuthRouter.dart``` for **authentication** state management regarding
* ```CalendarBlocBuilder.dart``` and ```CalendarBlocProvider.dart``` for state management regarding the **Calendar**.
* ```WeightRouter.dart``` for state management regarding the **weigth report funcitonality**

#### Why didn't we use the Bloc pattern on the entire application?
TL:DR; We tried, but it led to too much uneccessary code.

Because the application's design and structure was so volatile and in constant change, the setup with the Bloc pattern and every state for every screen led to more work than benefits from the pattern. For example, in the ```CreateCalendarEventScreen.dart``` for creating new calendar events, we just wanted a simple form with a simple POST request. While we are waiting for the request to return we display a loading spinner. If the request/form validation fails, show some error feedback. If the request succeeds, then update the calendar and show some success feedback. This could be done in a few lines, **in the same file** as the component itself, making it very readable and seperate from everything else. With Bloc however, we needed repositories, events, states... for such a simple task.