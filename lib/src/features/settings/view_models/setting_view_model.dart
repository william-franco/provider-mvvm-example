// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:provider_mvvm_example/src/features/settings/repositories/setting_repository.dart';

abstract base class SettingViewModel extends ValueNotifier<bool> {
  SettingViewModel() : super(false);

  Future<void> loadTheme();
  Future<void> changeTheme({required bool isDarkTheme});
}

base class SettingViewModelImpl extends ValueNotifier<bool>
    implements SettingViewModel {
  final SettingRepository settingRepository;

  SettingViewModelImpl({
    required this.settingRepository,
  }) : super(false) {
    loadTheme();
  }

  @override
  Future<void> loadTheme() async {
    final isDarkTheme = await settingRepository.readTheme();
    value = isDarkTheme;
    _debug();
    notifyListeners();
  }

  @override
  Future<void> changeTheme({required bool isDarkTheme}) async {
    value = isDarkTheme;
    await settingRepository.updateTheme(isDarkTheme: isDarkTheme);
    _debug();
    notifyListeners();
  }

  void _debug() {
    log('Dark theme: $value');
  }
}
