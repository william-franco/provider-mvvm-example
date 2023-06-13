// Project imports:
import 'package:provider_mvvm_example/src/environments/environments.dart';
import 'package:provider_mvvm_example/src/features/todos/models/todo_model.dart';
import 'package:provider_mvvm_example/src/services/http_service.dart';

abstract interface class TodoRepository {
  Future<TodoModel> readTodo(String id);
  Future<List<TodoModel>> readTodos();
}

class TodoRepositoryImpl implements TodoRepository {
  final HttpService httpService;

  TodoRepositoryImpl({
    required this.httpService,
  });

  @override
  Future<TodoModel> readTodo(String id) async {
    final response = await httpService.getData(
      path: '${Environments.baseURL}${Environments.todos}$id',
    );
    try {
      if (response.statusCode == 200) {
        final success = TodoModel.fromJson(response.data);
        return success;
      } else {
        throw Exception('Failed to load todo. ${response.statusMessage}');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<List<TodoModel>> readTodos() async {
    final response = await httpService.getData(
      path: '${Environments.baseURL}${Environments.todos}',
    );
    try {
      if (response.statusCode == 200) {
        final success =
            (response.data as List).map((e) => TodoModel.fromJson(e)).toList();
        return success;
      } else {
        throw Exception('Failed to load todos. ${response.statusMessage}');
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
