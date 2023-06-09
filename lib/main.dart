// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:provider_mvvm_example/src/dependency_injector/dependency_injector.dart';
import 'package:provider_mvvm_example/src/features/settings/view_models/setting_view_model.dart';
import 'package:provider_mvvm_example/src/routes/routes.dart';

void main() {
  runApp(
    const DependencyInjector(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = context.watch<SettingViewModel>().value;
    return MaterialApp.router(
      title: 'Provider MVVM Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      routerConfig: routesApp.routes,
    );
  }
}
