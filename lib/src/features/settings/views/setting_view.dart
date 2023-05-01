import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_mvvm_example/src/common_widgets/common_padding.dart';
import 'package:provider_mvvm_example/src/features/settings/view_models/setting_view_model.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = context.watch<SettingViewModel>().isDarkTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Settings'),
      ),
      body: CommonPadding(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.brightness_6_outlined),
              title: const Text('Dark theme'),
              trailing: Switch(
                value: isDarkTheme,
                onChanged: (bool enabled) {
                  context.read<SettingViewModel>().changeTheme(enabled);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
