// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/material.dart';

abstract base class BottomViewModel extends ValueNotifier<int> {
  BottomViewModel() : super(0);

  void changeIndexBottom({required int index});
}

base class BottomViewModelImpl extends ValueNotifier<int>
    implements BottomViewModel {
  BottomViewModelImpl() : super(0);

  @override
  void changeIndexBottom({required int index}) {
    value = index;
    _debug();
    notifyListeners();
  }

  void _debug() {
    log('Tab: $value');
  }
}
