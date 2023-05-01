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

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  Future<void> _loadTheme() async {
    _isDarkTheme = await settingRepository.readTheme();
    _debug();
    notifyListeners();
  }

  Future<void> changeTheme(bool isDarkTheme) async {
    _isDarkTheme = isDarkTheme;
    await settingRepository.updateTheme(isDarkTheme: isDarkTheme);
    _debug();
    notifyListeners();
  }

  void _debug() {
    log('Dark theme: $_isDarkTheme');
  }
}
