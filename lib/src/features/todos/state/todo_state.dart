// Project imports:
import 'package:provider_mvvm_example/src/features/todos/models/todo_model.dart';

sealed class TodoState {}

final class TodoInitial extends TodoState {}

final class TodoLoading extends TodoState {}

final class TodoSuccess extends TodoState {
  final List<TodoModel> todos;

  TodoSuccess({required this.todos});
}

final class TodoFailure extends TodoState {
  final String message;

  TodoFailure({required this.message});
}
