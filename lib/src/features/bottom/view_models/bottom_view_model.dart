import 'dart:developer';

import 'package:flutter/material.dart';

class BottomViewModel extends ChangeNotifier {
  BottomViewModel();

  int _tab = 0;
  int get tab => _tab;

  void changeTab(int index) {
    _tab = index;
    _debug();
    notifyListeners();
  }

  void _debug() {
    log('Tab: $_tab');
  }
}
