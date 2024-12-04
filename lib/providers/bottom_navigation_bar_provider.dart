import 'package:flutter/material.dart';
import 'package:stones_classifier/pages/classify_page.dart';
import 'package:stones_classifier/pages/home_page.dart';
import 'package:stones_classifier/pages/profile_page.dart';

class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  body() {
    switch (_currentIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const ClassifyPage();
      case 2:
        return const ProfilePage();
      default:
    }
  }

  setCurrentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }
}
