import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider_mvvm_example/src/features/todos/models/todo_model.dart';
import 'package:provider_mvvm_example/src/features/todos/repositories/todo_repository.dart';

class TodoViewModel extends ChangeNotifier {
  final TodoRepository todoRepository;

  TodoViewModel({
    required this.todoRepository,
  });

  List<TodoModel> _todos = [];
  List<TodoModel> get todos => _todos;

  Future<List<TodoModel>> loadTodos() async {
    _todos = await todoRepository.readTodos();
    _debug();
    notifyListeners();
    return _todos;
  }

  Future<void> refreshTodos() async {
    _todos = await todoRepository.readTodos();
    _debug();
    notifyListeners();
  }

  void _debug() {
    log('Todos: $_todos');
  }
}
