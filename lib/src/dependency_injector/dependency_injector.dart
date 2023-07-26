// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:provider_mvvm_example/src/dependency_injector/locator_injector.dart';
import 'package:provider_mvvm_example/src/features/bottom/view_models/bottom_view_model.dart';
import 'package:provider_mvvm_example/src/features/photos/repositories/photo_repository.dart';
import 'package:provider_mvvm_example/src/features/photos/view_models/photo_view_model.dart';
import 'package:provider_mvvm_example/src/features/settings/repositories/setting_repository.dart';
import 'package:provider_mvvm_example/src/features/settings/view_models/setting_view_model.dart';
import 'package:provider_mvvm_example/src/features/todos/repositories/todo_repository.dart';
import 'package:provider_mvvm_example/src/features/todos/view_models/todo_view_model.dart';

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
        // ViewModels
        ChangeNotifierProvider<BottomViewModel>(
          create: (context) => BottomViewModelImpl(),
        ),
        ChangeNotifierProvider<PhotoViewModel>(
          create: (context) => PhotoViewModelImpl(
            photoRepository: locator<PhotoRepository>(),
          ),
        ),
        ChangeNotifierProvider<TodoViewModel>(
          create: (context) => TodoViewModelImpl(
            todoRepository: locator<TodoRepository>(),
          ),
        ),
        ChangeNotifierProvider<SettingViewModel>(
          create: (context) => SettingViewModelImpl(
            settingRepository: locator<SettingRepository>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
