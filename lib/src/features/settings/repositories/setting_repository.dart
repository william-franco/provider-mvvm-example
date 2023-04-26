import 'package:provider_mvvm_example/src/constants/constants.dart';
import 'package:provider_mvvm_example/src/services/storage_service.dart';

class SettingRepository {
  final StorageService storageService;

  SettingRepository({
    required this.storageService,
  });

  Future<bool> readTheme() async {
    final isDarkMode = await storageService.getBoolValue(
      key: Constants.darkMode,
    );
    return isDarkMode;
  }

  Future<void> updateTheme(bool isDarkTheme) async {
    await storageService.setBoolValue(
      key: Constants.darkMode,
      value: isDarkTheme,
    );
  }
}
