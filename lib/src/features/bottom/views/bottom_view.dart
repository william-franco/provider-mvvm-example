// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:provider_mvvm_example/src/features/bottom/view_models/bottom_view_model.dart';
import 'package:provider_mvvm_example/src/features/photos/views/photo_view.dart';
import 'package:provider_mvvm_example/src/features/settings/views/setting_view.dart';
import 'package:provider_mvvm_example/src/features/todos/views/todo_view.dart';

class BottomView extends StatefulWidget {
  const BottomView({super.key});

  @override
  State<BottomView> createState() => _BottomViewState();
}

class _BottomViewState extends State<BottomView> {
  final listOfWidgets = const <Widget>[
    PhotoView(),
    TodoView(),
    SettingView(),
  ];

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<BottomViewModel>();
    return Scaffold(
      body: listOfWidgets.elementAt(viewModel.value.indexTab),
      bottomNavigationBar: NavigationBar(
        selectedIndex: viewModel.value.indexTab,
        animationDuration: const Duration(milliseconds: 600),
        onDestinationSelected: (int index) {
          context.read<BottomViewModel>().changeIndexBottom(index: index);
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            label: 'Photos',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_outlined),
            label: 'Todos',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
