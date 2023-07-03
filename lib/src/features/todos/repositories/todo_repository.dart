// Project imports:
import 'package:provider_mvvm_example/src/environments/environments.dart';
import 'package:provider_mvvm_example/src/exception_handling/exception_handling.dart';
import 'package:provider_mvvm_example/src/features/todos/models/todo_model.dart';
import 'package:provider_mvvm_example/src/services/http_service.dart';

abstract interface class TodoRepository {
  Future<Result<TodoModel, Exception>> readTodo(String id);
  Future<Result<List<TodoModel>, Exception>> readTodos();
}

class TodoRepositoryImpl implements TodoRepository {
  final HttpService httpService;

  TodoRepositoryImpl({
    required this.httpService,
  });

  @override
  Future<Result<TodoModel, Exception>> readTodo(String id) async {
    try {
      final response = await httpService.getData(
        path: '${Environments.baseURL}${Environments.todos}$id',
      );
      switch (response.statusCode) {
        case 200:
          final success = TodoModel.fromJson(response.data);
          return Success(value: success);
        default:
          return Failure(exception: Exception(response.statusMessage));
      }
    } on Exception catch (error) {
      return Failure(exception: error);
    }
  }

  @override
  Future<Result<List<TodoModel>, Exception>> readTodos() async {
    try {
      final response = await httpService.getData(
        path: '${Environments.baseURL}${Environments.todos}',
      );
      switch (response.statusCode) {
        case 200:
          final success = (response.data as List)
              .map((e) => TodoModel.fromJson(e))
              .toList();
          return Success(value: success);
        default:
          return Failure(exception: Exception(response.statusMessage));
      }
    } on Exception catch (error) {
      return Failure(exception: error);
    }
  }
}
