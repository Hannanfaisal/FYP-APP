import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier{

  Locale? _appLocale;

  Locale? get appLocale => _appLocale;

  changeLanguage(type) async {

    SharedPreferences sp = await SharedPreferences.getInstance();
    _appLocale = type;
    if(type == const Locale('en')){
      await sp.setString('language_code', 'en');
    }
    else{
      await sp.setString('language_code', 'ur');
    }

    notifyListeners();
  }


}