import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool isDarkMode = false;
  bool isFahrenheit = false;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }

  void toggleUnit() {
    isFahrenheit = !isFahrenheit;
    notifyListeners();
  }

  String get unitLabel => isFahrenheit ? '°F' : '°C';
}
