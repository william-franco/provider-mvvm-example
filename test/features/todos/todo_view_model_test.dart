// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:provider_mvvm_example/src/features/todos/repositories/todo_repository.dart';
import 'package:provider_mvvm_example/src/features/todos/state/todo_state.dart';
import 'package:provider_mvvm_example/src/features/todos/view_models/todo_view_model.dart';
import 'package:provider_mvvm_example/src/services/http_service.dart';

void main() {
  group('TodoViewModel', () {
    late HttpService httpService;
    late TodoRepository todoRepository;
    late TodoViewModel todoViewModel;

    setUp(() {
      httpService = HttpServiceImpl();
      todoRepository = TodoRepositoryImpl(httpService: httpService);
      todoViewModel = TodoViewModelImpl(todoRepository: todoRepository);
    });

    test('Value should be initial state', () {
      expect(todoViewModel.value, isA<TodoInitial>());
    });

    test('Value should be success state', () async {
      await todoViewModel.loadTodos();
      expect(todoViewModel.value, isA<TodoSuccess>());
    });
  });
}
