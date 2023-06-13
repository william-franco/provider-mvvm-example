// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:provider_mvvm_example/src/common_widgets/common_padding.dart';
import 'package:provider_mvvm_example/src/common_widgets/common_responsive_list_or_grid_view_builder.dart';
import 'package:provider_mvvm_example/src/features/todos/state/todo_state.dart';
import 'package:provider_mvvm_example/src/features/todos/view_models/todo_view_model.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      context.read<TodoViewModel>().loadTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Photos'),
      ),
      body: CommonPadding(
        child: RefreshIndicator(
          onRefresh: () {
            return context.read<TodoViewModel>().loadTodos();
          },
          child: Consumer<TodoViewModel>(
            builder: (context, state, child) {
              return switch (state.value) {
                TodoInitial() => const Text('List is empty.'),
                TodoLoading() => const CircularProgressIndicator(),
                TodoSuccess(todos: final todos) =>
                  CommonResponsiveListOrGridViewBuilder(
                    itemCount: todos.length,
                    itemGridBuilder: (BuildContext context, int index) {
                      final todo = todos[index];
                      return Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              todo.title!,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text('Completed: ${todo.completed!}'),
                          ],
                        ),
                      );
                    },
                    itemListBuilder: (BuildContext context, int index) {
                      final todo = todos[index];
                      return Card(
                        child: ListTile(
                          title: Text(
                            todo.title!,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text('Completed: ${todo.completed!}'),
                        ),
                      );
                    },
                  ),
                TodoFailure(message: final message) => Text(message),
              };
            },
          ),
        ),
      ),
    );
  }
}
