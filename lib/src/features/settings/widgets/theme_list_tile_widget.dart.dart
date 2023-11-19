// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:provider_mvvm_example/src/features/settings/view_models/setting_view_model.dart';

class ThemeListTileWidget extends StatelessWidget {
  const ThemeListTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SettingViewModel>();
    return ListTile(
      leading: const Icon(Icons.brightness_6_outlined),
      title: const Text('Dark theme'),
      trailing: Switch(
        value: viewModel.value.isDarkTheme,
        onChanged: (bool enabled) {
          context.read<SettingViewModel>().changeTheme(isDarkTheme: enabled);
        },
      ),
    );
  }
}
