// Package imports:
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:provider_mvvm_example/src/features/photos/repositories/photo_repository.dart';
import 'package:provider_mvvm_example/src/features/settings/repositories/setting_repository.dart';
import 'package:provider_mvvm_example/src/features/todos/repositories/todo_repository.dart';
import 'package:provider_mvvm_example/src/services/http_service.dart';
import 'package:provider_mvvm_example/src/services/storage_service.dart';

final locator = GetIt.instance;

void locatorInjector() {
  startModuleHttp();
  startModulePhotos();
  startModuleTodos();
  startModuleSettings();
}

void startModuleHttp() {
  // Services
  locator.registerFactory<HttpService>(
    () => HttpServiceImpl(),
  );
}

void startModulePhotos() {
  // Repositories
  locator.registerFactory<PhotoRepository>(
    () => PhotoRepositoryImpl(
      httpService: locator<HttpService>(),
    ),
  );
}

void startModuleTodos() {
  // Repositories
  locator.registerFactory<TodoRepository>(
    () => TodoRepositoryImpl(
      httpService: locator<HttpService>(),
    ),
  );
}

void startModuleSettings() {
  // Services
  locator.registerFactory<StorageService>(
    () => StorageServiceImpl(),
  );
  // Repositories
  locator.registerFactory<SettingRepository>(
    () => SettingRepositoryImpl(
      storageService: locator<StorageService>(),
    ),
  );
}
