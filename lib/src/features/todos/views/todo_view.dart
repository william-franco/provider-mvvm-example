import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_mvvm_example/src/common_widgets/common_padding.dart';
import 'package:provider_mvvm_example/src/common_widgets/common_responsive_list_or_grid_view_builder.dart';
import 'package:provider_mvvm_example/src/features/todos/view_models/todo_view_model.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: CommonPadding(
        child: RefreshIndicator(
          onRefresh: () {
            return context.read<TodoViewModel>().refreshTodos();
          },
          child: FutureBuilder(
            future: context.read<TodoViewModel>().loadTodos(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return CommonResponsiveListOrGridViewBuilder(
                  itemCount: snapshot.data!.length,
                  itemGridBuilder: (BuildContext context, int index) {
                    final todo = snapshot.data![index];
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
                    final todo = snapshot.data![index];
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
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
