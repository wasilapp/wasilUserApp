import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sizer/sizer.dart';
import 'package:userwasil/providers/darktheme.dart';
import 'package:userwasil/utils/theme/theme.dart';
import 'package:userwasil/views/splash_screen/splash_screen.dart';

import 'generated/l10n.dart';
import 'l10n/app_language.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {



  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppThemeNotifier themeChangeProvider = AppThemeNotifier();


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return ScopedModelDescendant<AppLanguage>(builder: (context, child, model) {
      return MultiProvider(
        providers: [
    ChangeNotifierProvider<AppThemeNotifier>(
    create: (context) => AppThemeNotifier()),],
        child:
        Consumer<AppThemeNotifier>(
            builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
              return

                Sizer(builder: (context, orientation, deviceType)
                {
                  return Directionality(
                      textDirection: TextDirection.rtl,

                      child:
                      MaterialApp(
                        debugShowCheckedModeBanner: false,
                        theme: AppTheme.getThemeFromThemeMode(
                            value.themeMode()),
                        // locale: model.appLocale,
                        // supportedLocales: S.delegate.supportedLocales,
                        // localizationsDelegates: const [
                        //   S.delegate,
                        //   GlobalMaterialLocalizations.delegate,
                        //   GlobalCupertinoLocalizations.delegate,
                        //   GlobalWidgetsLocalizations.delegate,
                        // ],
                        home: const SplashScreen(),
                      ));
                });
  }),

    );
    }

 }