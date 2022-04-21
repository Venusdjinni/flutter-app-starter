import 'package:flutter/material.dart';
import 'package:flutter_app_starter/colors.dart';
import 'package:flutter_app_starter/requests/datamanager.dart';
import 'package:flutter_app_starter/screens/home.dart';
import 'package:flutter_app_starter/screens/signup.dart';

final AppThemeMode appThemeMode = AppThemeMode();

void main() async {
  await appThemeMode.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = ThemeData(
      colorScheme: const ColorScheme.light(
        primary: AppColors.color1,
        secondary: AppColors.color2
      )
    );

    ThemeData darkTheme = ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: AppColors.color1,
        secondary: AppColors.color2
      )
    );

    return MaterialApp(
      title: 'Flutter App Starter',
      theme: theme,
      darkTheme: darkTheme,
      themeMode: ((){
        switch (appThemeMode.themeMode) {
          case AppThemeMode.dark: return ThemeMode.dark;
          case AppThemeMode.system: return ThemeMode.system;
          default: return ThemeMode.light;
        }
      })(),
      //home: const HomeScreen(),
      home: FutureBuilder(
        future: DataManager.init(),
        builder: (_, s) {
          if (s.hasError) {
            print('${s.error}');
            return Container(color: Colors.red,);
          }
          if (!s.hasData) {
            return Container(color: AppColors.color1,);
          }
          if (s.hasData) {
            // example of how to use
            return DataManager.preferences!.getBool(DataManager.prefUserLogged) ?? false ?
              const HomeScreen() :
              const SignupScreen();
          }
          return Container();
        },
      )
    );
  }
}
