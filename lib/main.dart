import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_app_ui/screens/splash/splash.dart';
import 'package:social_app_ui/services/auth.dart';
import 'package:social_app_ui/util/const.dart';
import 'package:social_app_ui/util/theme_config.dart';
import 'package:social_app_ui/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:social_app_ui/models/user.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.appName,
        theme: themeData(ThemeConfig.lightTheme),
        darkTheme: themeData(ThemeConfig.darkTheme),
        home: Wrapper(),
      ),
    );
  }

  ThemeData themeData(ThemeData theme) {
    return theme.copyWith(
      textTheme: GoogleFonts.sourceSansProTextTheme(
        theme.textTheme,
      ),
    );
  }
}
