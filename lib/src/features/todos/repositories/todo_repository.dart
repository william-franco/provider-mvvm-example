import 'package:provider_mvvm_example/src/environments/environments.dart';
import 'package:provider_mvvm_example/src/features/todos/models/todo_model.dart';
import 'package:provider_mvvm_example/src/services/http_service.dart';

class TodoRepository {
  final HttpService httpService;

  TodoRepository({
    required this.httpService,
  });

  Future<TodoModel> readTodo(String id) async {
    final response = await httpService.getData(
      path: '${Environments.baseURL}${Environments.todos}/$id',
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
