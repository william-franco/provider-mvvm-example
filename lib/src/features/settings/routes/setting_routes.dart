import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:provider_mvvm_example/src/features/settings/view_models/setting_view_model.dart';
import 'package:provider_mvvm_example/src/features/settings/views/setting_view.dart';

class SettingRoutes {
  static String get setting => '/setting';

  List<GoRoute> get routes => _routes;

  final List<GoRoute> _routes = [
    GoRoute(
      path: setting,
      builder: (context, state) {
        return SettingView(settingViewModel: context.read<SettingViewModel>());
      },
    ),
  ];
}
