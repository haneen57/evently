
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier{
  String appLang='en';
  void changeLang(String newLang){
    if(appLang==newLang){
      return;
    }
    else{
      appLang=newLang;
    }
    notifyListeners();
  }
  ThemeMode appTheme=ThemeMode.light;
  void changeTheme(ThemeMode newTheme){
    if(appTheme==newTheme){
      return;
    }
    else{
       appTheme=newTheme;
    }
    notifyListeners();
  }
}