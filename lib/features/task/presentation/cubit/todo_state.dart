part of 'todo_cubit.dart';

abstract class TodoState {
  const TodoState();
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;

  TodoLoaded({required this.todos});
}

class TodoError extends TodoState {
  final String message;

  TodoError({required this.message});
}
