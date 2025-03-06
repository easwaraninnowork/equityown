import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quityown/controller/language_change_controller.dart';
import 'package:quityown/pages/SplashScreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';

void main() async{
 /* WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =  "pk_test_51ObOJGSHf8pI4XiFR7I20iLREtO0A3OqAknXJtbDLAHNa2D9eT08F2TzaH1vB0fhFruyQq5Al3A4tRzb07rZm8QJ00yg8xqcYb";*/
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => LanguageChangeController())
    ],
    child: Consumer<LanguageChangeController>(
      builder: (context,provider,child){
        return MaterialApp(
          locale: provider.appLocale,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: [
            Locale('en'),
            Locale('es')
          ],
          debugShowCheckedModeBanner: false,
          home : SplashPage(),
        );
      },
    ));

  }

}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}




