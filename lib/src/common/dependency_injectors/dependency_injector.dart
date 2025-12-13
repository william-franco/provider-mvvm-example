import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_mvvm_example/src/common/services/connection_service.dart';
import 'package:provider_mvvm_example/src/common/services/http_service.dart';
import 'package:provider_mvvm_example/src/common/services/storage_service.dart';
import 'package:provider_mvvm_example/src/features/settings/repositories/setting_repository.dart';
import 'package:provider_mvvm_example/src/features/settings/view_models/setting_view_model.dart';
import 'package:provider_mvvm_example/src/features/users/repositories/user_repository.dart';
import 'package:provider_mvvm_example/src/features/users/view_models/user_view_model.dart';

class DependencyInjector extends StatefulWidget {
  final Widget child;

  const DependencyInjector({super.key, required this.child});

  @override
  State<DependencyInjector> createState() => _DependencyInjectorState();
}

class _DependencyInjectorState extends State<DependencyInjector> {
  // Services
  late final ConnectionService connectionService;
  late final HttpService httpService;
  late final StorageService storageService;

  // Repositories
  late final SettingRepository settingRepository;
  late final UserRepository userRepository;

  // ViewModels
  late final SettingViewModel settingViewModel;
  late final UserViewModel userViewModel;

  @override
  void initState() {
    super.initState();
    // Services
    connectionService = ConnectionServiceImpl();
    httpService = HttpServiceImpl();
    storageService = StorageServiceImpl();

    // Repositories
    settingRepository = SettingRepositoryImpl(storageService: storageService);
    userRepository = UserRepositoryImpl(
      connectionService: connectionService,
      httpService: httpService,
    );

    // ViewModels
    settingViewModel = SettingViewModelImpl(
      settingRepository: settingRepository,
    );
    userViewModel = UserViewModelImpl(userRepository: userRepository);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initDependencies();
    });
  }

  Future<void> _initDependencies() async {
    await Future.wait([
      connectionService.checkConnection(),
      storageService.initStorage(),
    ]);
    await settingViewModel.getTheme();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Services
        Provider<ConnectionService>.value(value: connectionService),
        Provider<HttpService>.value(value: httpService),
        Provider<StorageService>.value(value: storageService),
        // Repositories
        Provider<SettingRepository>.value(value: settingRepository),
        Provider<UserRepository>.value(value: userRepository),
        // ViewModels
        ChangeNotifierProvider<SettingViewModel>.value(value: settingViewModel),
        ChangeNotifierProvider<UserViewModel>.value(value: userViewModel),
      ],
      child: widget.child,
    );
  }
}
