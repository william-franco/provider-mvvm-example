// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:provider_mvvm_example/src/features/bottom/view_models/bottom_view_model.dart';

void main() {
  group('BottomViewModel', () {
    late BottomViewModel viewModel;

    setUp(() {
      viewModel = BottomViewModel();
    });

    test('initial value is 0', () {
      expect(viewModel.value, 0);
    });

    test('change index', () {
      viewModel.changeIndexBottom(1);
      expect(viewModel.value, 1);
    });
  });
}
