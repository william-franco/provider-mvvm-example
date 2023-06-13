// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:provider_mvvm_example/src/features/todos/models/todo_model.dart';
import 'package:provider_mvvm_example/src/features/todos/repositories/todo_repository.dart';
import 'package:provider_mvvm_example/src/services/http_service.dart';

void main() {
  group('TodoRepository', () {
    late HttpService httpService;
    late TodoRepository todoRepository;

    setUp(() {
      httpService = HttpServiceImpl();
      todoRepository = TodoRepositoryImpl(httpService: httpService);
    });

    test('Value expected should be an item of type TodoModel', () async {
      final todo = await todoRepository.readTodo('1');
      expect(todo, isA<TodoModel>());
    });

    test('Value expected should be an item of type List<TodoModel>', () async {
      final todos = await todoRepository.readTodos();
      expect(todos, isA<List<TodoModel>>());
    });
  });
}
