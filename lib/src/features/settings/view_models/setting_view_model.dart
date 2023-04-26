import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider_mvvm_example/src/features/settings/repositories/setting_repository.dart';

class SettingViewModel extends ChangeNotifier {
  final SettingRepository settingRepository;

  SettingViewModel({
    required this.settingRepository,
  }) {
    _loadTheme();
  }

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  Future<void> _loadTheme() async {
    _isDarkMode = await settingRepository.readTheme();
    _debug();
    notifyListeners();
  }

  Future<void> changeTheme(bool isDarkMode) async {
    _isDarkMode = isDarkMode;
    await settingRepository.updateTheme(isDarkMode);
    _debug();
    notifyListeners();
  }

  void _debug() {
    log('Dark theme: $_isDarkMode');
  }
}
