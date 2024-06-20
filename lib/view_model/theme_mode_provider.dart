

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeProvider with ChangeNotifier{

  ThemeMode _themeMode = ThemeMode.light;

  int selected = 1;


  ThemeMode get themeMode => _themeMode;

  changeThemeMode(themeMode, selectedValue) async {

   String? theme;
    if(themeMode == ThemeMode.light){
      theme = 'light';
    }else{
      theme = 'dark';
    }
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('themeMode', theme);
    _themeMode = themeMode;
    selected = selectedValue;
    notifyListeners();

  }

}