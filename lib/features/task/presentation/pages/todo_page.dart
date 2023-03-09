import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simpletodoapp/core/di/service_locator.dart';

import '../cubit/todo_cubit.dart';

class TodoPage extends StatelessWidget {
  static const routeName = 'todo_page';

  const TodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(
      bloc: getIt<TodoCubit>(),
      builder: (context, state) {
        final TodoCubit todoCubit = BlocProvider.of<TodoCubit>(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Todo List'),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              )
            ],
          ),
          body: body(todoCubit, state),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              final TextEditingController controller = TextEditingController();
              await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Add Todo'),
                    content: TextFormField(
                      controller: controller,
                      decoration: const InputDecoration(hintText: 'Todo title'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        child: const Text('Add'),
                        onPressed: () async {
                          final String title = controller.text;
                          if (title.isNotEmpty) {
                            await todoCubit.addTodo(title: title);
                          }
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget body(TodoCubit todoCubit, TodoState state) {
    if (state is TodoLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (state is TodoLoaded) {
      ListView.builder(
        itemCount: state.todos.length,
        itemBuilder: (context, index) {
          final Todo todo = state.todos[index];
          return ListTile(
            title: Text(todo.title),
            leading: Checkbox(
              value: todo.completed,
              onChanged: (_) async {
                await todoCubit.toggleTodoComplete(todo: todo);
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await todoCubit.deleteTodo(todo: todo);
              },
            ),
          );
        },
      );
    } else if (state is TodoError) {
      return Scaffold(
        body: Center(
          child: Text(state.message),
        ),
      );
    }

    return Scaffold(body: Container());
  }
}
