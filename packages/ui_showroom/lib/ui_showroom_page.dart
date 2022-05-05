library ui_showroom;

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_library/ui_library_export.dart';
import 'package:ui_showroom/ui_pages/src/u_user_profile_cards_page.dart';
import 'package:ui_showroom/ui_pages/ui_pages_export.dart';

class UIShowRoomApp extends StatelessWidget {
  const UIShowRoomApp({Key? key, required this.themeData}) : super(key: key);
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      initialRoute: '/',
      routes: {
        UIconPage.routeName: (context) => const UIconPage(),
        UColorsPage.routeName: (context) => const UColorsPage(),
        UTextPage.routeName: (context) => const UTextPage(),
        UUserProfilePage.routeName: (context) => const UUserProfilePage(),
        UAvatarProfilePage.routeName: (context) => const UAvatarProfilePage(),
        UButtonPage.routeName: (context) => const UButtonPage(),
        UIconButtonPage.routeName: (context) => const UIconButtonPage(),
        UFABPage.routeName: (context) => const UFABPage(),
        ULogoutButtonPage.routeName: (context) => const ULogoutButtonPage(),
        UUserProfileCardsPage.routeName: (context) =>
            const UUserProfileCardsPage(),
      },
      home: Scaffold(
        appBar: AppBar(
          title: const ThemeDropdownButton(),
        ),
        body: Center(
          child: ListView(
            children: [
              const SizedBox.square(
                dimension: 16,
              ),
              Image.asset(
                'packages/ui_showroom/images/CHEEKY_POSE_SUBMIT_LAYERS.gif',
                height: 164,
                width: 164,
              ),
              Align(
                alignment: Alignment.center,
                child: UText(
                  'Welcome to our UI Showroom App, \nknow our library!',
                  textStyle: UTextStyle.H4_fourthHeader,
                  textAlign: TextAlign.center,
                  textColor: themeData.colorScheme.secondary,
                ),
              ),
              const SizedBox.square(
                dimension: 16,
              ),
              const _WidgetsShowSession(
                sessionTitle: 'Core Widgets and Specs',
                sessionWidgets: [
                  WidgetPageButton(
                    widgetName: UIconPage.routeName,
                  ),
                  WidgetPageButton(
                    widgetName: UColorsPage.routeName,
                  ),
                  WidgetPageButton(
                    widgetName: UTextPage.routeName,
                  ),
                ],
              ),
              const _WidgetsShowSession(
                sessionTitle: 'Basic Profile Widgets',
                sessionWidgets: [
                  WidgetPageButton(
                    widgetName: UUserProfilePage.routeName,
                  ),
                  WidgetPageButton(
                    widgetName: UAvatarProfilePage.routeName,
                  ),
                ],
              ),
              const _WidgetsShowSession(
                sessionTitle: 'Avatar Card Widgets',
                sessionWidgets: [
                  WidgetPageButton(
                    widgetName: UUserProfileCardsPage.routeName,
                  ),
                ],
              ),
              const _WidgetsShowSession(
                sessionTitle: 'Button Session Widgets',
                sessionWidgets: [
                  WidgetPageButton(
                    widgetName: UButtonPage.routeName,
                  ),
                  WidgetPageButton(
                    widgetName: UIconButtonPage.routeName,
                  ),
                  WidgetPageButton(
                    widgetName: UFABPage.routeName,
                  ),
                  WidgetPageButton(
                    widgetName: ULogoutButtonPage.routeName,
                  ),
                  WidgetPageButton(
                    widgetName: UUserProfileCardsPage.routeName,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WidgetsShowSession extends StatelessWidget {
  const _WidgetsShowSession(
      {Key? key, required this.sessionWidgets, required this.sessionTitle})
      : super(key: key);

  final List<Widget> sessionWidgets;

  final String sessionTitle;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _sessionWidgets = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: UText(
          sessionTitle,
          textStyle: UTextStyle.H4_fourthHeader,
        ),
      ),
    ];
    for (var element in sessionWidgets) {
      _sessionWidgets.add(element);
    }
    _sessionWidgets.add(
      const Divider(
        thickness: 1,
        indent: 16,
        endIndent: 16,
        color: Colors.white,
      ),
    );
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _sessionWidgets,
    );
  }
}

class ThemeDropdownButton extends StatelessWidget {
  const ThemeDropdownButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final themeModel = context.watch<ThemeModel>();

    return DropdownButton(
      items: const [
        DropdownMenuItem(
          child: Text('light'),
          value: 'light',
        ),
        DropdownMenuItem(
          child: Text('dark'),
          value: 'dark',
        ),
        DropdownMenuItem(
          child: Text('TBD'),
          value: 'tbd',
        ),
      ],
      value: themeModel.getThemeType.toStrName(),
      onChanged: (value) {
        if (value is String) {
          final _themeModel = context.read<ThemeModel>();
          _themeModel.setTheme(value.toThemeType());
        } else {
          log('Error(ThemeDropdownButton):value is not a String');
        }
      },
    );
  }
}

class WidgetPageButton extends StatelessWidget {
  const WidgetPageButton({Key? key, required this.widgetName})
      : super(key: key);

  final String widgetName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: UColors.ctaBlue),
        onPressed: () {
          Navigator.pushNamed(context, widgetName);
        },
        child: Text(widgetName.substring(1)),
      ),
    );
  }
}
