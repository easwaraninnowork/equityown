

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChangeController with ChangeNotifier {

  Locale? _appLocale;
  Locale? get appLocale => _appLocale;

  void changeLanguage(Locale type) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _appLocale = type;


    if(type == Locale('en')){
      await sharedPreferences.setString('language_code', 'en');
    }else{
      await sharedPreferences.setString('language_code', 'es');
    }
    notifyListeners();
  }

}