import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:global_configuration/global_configuration.dart';

import 'generated/l10n.dart';
import 'route_generator.dart';
import 'src/helpers/app_config.dart' as config;
import 'src/models/setting.dart';
import 'src/repository/settings_repository.dart' as settingRepo;
import 'src/repository/user_repository.dart' as userRepo;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("configurations");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

//  MyApp({Key key}) : super(con: Controller(), key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    settingRepo.initSettings();
    settingRepo.getCurrentLocation();
    userRepo.getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: settingRepo.setting,
        builder: (context, Setting _setting, _) {
          print(_setting.toMap());
          return MaterialApp(
              navigatorKey: settingRepo.navigatorKey,
              title: _setting.appName,
              initialRoute: '/Splash',
              /*
              onGenerateRoute: RouteGenerator.generateRoute,

               */
              debugShowCheckedModeBanner: false,
              locale: _setting.mobileLanguage.value,
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              theme: _setting.brightness.value == Brightness.light
                  ? ThemeData(
                      fontFamily: 'ProductSans',
                      primaryColor: Colors.white,
                      floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: 0, foregroundColor: Colors.white),
                      brightness: Brightness.light,
                      accentColor: config.Colors().mainColor(1),
                      dividerColor: config.Colors().accentColor(0.1),
                      focusColor: config.Colors().accentColor(1),
                      hintColor: config.Colors().secondColor(1),
                      textTheme: TextTheme(
                        headline5: TextStyle(fontSize: 22.0, color: config.Colors().secondColor(1)),
                        headline4: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: config.Colors().secondColor(1)),

                      ),
                    )
                  : ThemeData(
                      fontFamily: 'ProductSans',
                      primaryColor: Color(0xFF252525),
                      brightness: Brightness.dark,
                      scaffoldBackgroundColor: Color(0xFF2C2C2C),
                      accentColor: config.Colors().mainDarkColor(1),
                      dividerColor: config.Colors().accentColor(0.1),
                      hintColor: config.Colors().secondDarkColor(1),
                      focusColor: config.Colors().accentDarkColor(1),
                      textTheme: TextTheme(
                        headline5: TextStyle(fontSize: 22.0, color: config.Colors().secondDarkColor(1)),
                        headline4: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: config.Colors().secondDarkColor(1)),
                        headline3: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: config.Colors().secondDarkColor(1)),

                      ),
                    ));
        });
  }
}
