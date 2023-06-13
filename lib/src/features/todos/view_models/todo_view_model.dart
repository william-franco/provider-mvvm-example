// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:provider_mvvm_example/src/features/todos/repositories/todo_repository.dart';
import 'package:provider_mvvm_example/src/features/todos/state/todo_state.dart';

abstract base class TodoViewModel extends ValueNotifier<TodoState> {
  TodoViewModel() : super(TodoInitial());

  Future<void> loadTodos();
}

base class TodoViewModelImpl extends ValueNotifier<TodoState>
    implements TodoViewModel {
  final TodoRepository todoRepository;

  TodoViewModelImpl({
    required this.todoRepository,
  }) : super(TodoInitial());

  @override
  Future<void> loadTodos() async {
    value = TodoLoading();
    final todos = await todoRepository.readTodos();
    value = TodoSuccess(todos: todos);
    _debug();
    notifyListeners();
  }

  void _debug() {
    log('Todo state: $value');
  }
}
