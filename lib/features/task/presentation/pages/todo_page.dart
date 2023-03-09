import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simpletodoapp/core/di/service_locator.dart';
import 'package:simpletodoapp/core/navigator/navigation.dart';
import 'package:simpletodoapp/core/theme/app_colors.dart';
import 'package:simpletodoapp/core/theme/text_style.dart';
import 'package:simpletodoapp/features/auth/presentation/pages/login_page.dart';

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
            backgroundColor: AppColors.primary,
            centerTitle: true,
            title: Text(
              'Todo List',
              style: AppTextStyle.headingBold20(
                AppColors.textWhite,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  getIt<NavigationService>().pushNamedAndRemoveUntil(
                    LoginPage.routeName,
                  );
                },
              )
            ],
          ),
          body: body(todoCubit, state),
          floatingActionButton: FloatingActionButton(
            child: const Icon(
              Icons.add,
            ),
            backgroundColor: AppColors.primary,
            onPressed: () async {
              final TextEditingController controller = TextEditingController();
              await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'Add Todo',
                      style: AppTextStyle.headingBold14(),
                    ),
                    content: TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'Todo title',
                        hintStyle: AppTextStyle.bodyRegular12(),
                      ),
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
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is TodoLoaded) {
     return ListView.builder(
        itemCount: state.todos.length,
        itemBuilder: (context, index) {
          final Todo todo = state.todos[index];
          return Container(
            margin: EdgeInsets.only(
              right: 12.w,
              left: 12.w,
              top: 12.h,
            ),
            padding: EdgeInsets.symmetric(
              vertical: 2.h,
              horizontal: 12.w,
            ),
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: todo.completed,
                  activeColor: Colors.white,
                  checkColor: Colors.black,
                  onChanged: (_) async {
                    await todoCubit.toggleTodoComplete(todo: todo);
                  },
                ),
                8.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        todo.title,
                        style: AppTextStyle.headingBold20(),
                      ),
                      Text(
                        todo.time,
                        style: AppTextStyle.bodyRegular12(),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline, color: AppColors.iconGrey),
                  onPressed: () async {
                    await todoCubit.deleteTodo(todo: todo);
                  },
                ),
              ],
            ),
          );
        },
      );
    } else if (state is TodoError) {
      return Center(
        child: Text(state.message),
      );
    }

    return Scaffold(body: Container());
  }
}
