import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_mvvm_example/src/features/bottom/view_models/bottom_view_model.dart';
import 'package:provider_mvvm_example/src/features/photos/repositories/photo_repository.dart';
import 'package:provider_mvvm_example/src/features/photos/view_models/photo_view_model.dart';
import 'package:provider_mvvm_example/src/features/settings/repositories/setting_repository.dart';
import 'package:provider_mvvm_example/src/features/settings/view_models/setting_view_model.dart';
import 'package:provider_mvvm_example/src/features/todos/repositories/todo_repository.dart';
import 'package:provider_mvvm_example/src/features/todos/view_models/todo_view_model.dart';
import 'package:provider_mvvm_example/src/services/http_service.dart';
import 'package:provider_mvvm_example/src/services/storage_service.dart';

class DependencyInjector extends StatelessWidget {
  final Widget child;

  const DependencyInjector({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Services
        Provider(
          create: (context) => HttpService(),
        ),
        Provider(
          create: (context) => StorageService(),
        ),
        // Repositories
        Provider(
          create: (context) => PhotoRepository(
            httpService: context.read<HttpService>(),
          ),
        ),
        Provider(
          create: (context) => TodoRepository(
            httpService: context.read<HttpService>(),
          ),
        ),
        Provider(
          create: (context) => SettingRepository(
            storageService: context.read<StorageService>(),
          ),
        ),
        // ViewModels
        ChangeNotifierProvider(
          create: (context) => BottomViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => PhotoViewModel(
            photoRepository: context.read<PhotoRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => TodoViewModel(
            todoRepository: context.read<TodoRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingViewModel(
            settingRepository: context.read<SettingRepository>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
