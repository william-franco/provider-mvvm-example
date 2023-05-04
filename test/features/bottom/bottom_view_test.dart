// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:provider_mvvm_example/src/dependency_injector/dependency_injector.dart';
import 'package:provider_mvvm_example/src/features/bottom/views/bottom_view.dart';
import 'package:provider_mvvm_example/src/features/photos/views/photo_view.dart';
import 'package:provider_mvvm_example/src/features/settings/views/setting_view.dart';
import 'package:provider_mvvm_example/src/features/todos/views/todo_view.dart';

void main() {
  group('BottomView', () {
    testWidgets('BottomView should change tabs', (WidgetTester tester) async {
      const widget = MaterialApp(
        home: DependencyInjector(
          child: BottomView(),
        ),
      );

      final photoView = find.byType(PhotoView);
      final todoView = find.byType(TodoView);
      final settingView = find.byType(SettingView);
      final listIcon = (find.byIcon(Icons.list_outlined));
      final settingsIcon = (find.byIcon(Icons.settings_outlined));

      await tester.pumpWidget(widget);

      expect(photoView, findsOneWidget);
      expect(todoView, findsNothing);
      expect(settingView, findsNothing);

      await tester.tap(listIcon);
      await tester.pumpAndSettle();

      expect(photoView, findsNothing);
      expect(todoView, findsOneWidget);
      expect(settingView, findsNothing);

      await tester.tap(settingsIcon);
      await tester.pumpAndSettle();

      expect(photoView, findsNothing);
      expect(todoView, findsNothing);
      expect(settingView, findsOneWidget);
    });
  });
}
