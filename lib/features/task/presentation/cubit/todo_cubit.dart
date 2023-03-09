import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';

part 'todo_state.dart';

@Injectable()
class TodoCubit extends Cubit<TodoState> {
  late final DatabaseReference _todoRef;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TodoCubit() : super(TodoInitial()) {
    final User? user = _auth.currentUser;
    if (user != null) {
      _todoRef = FirebaseDatabase.instance.reference().child('users/${user.uid}/todos');
      _todoRef.onValue.listen((event) {
        final data = event.snapshot.value as Map<dynamic, dynamic>?;
        final todos = data?.entries.map((e) {
          final key = e.key as String;
          final value = e.value as Map<dynamic, dynamic>;
          return Todo(
            id: key,
            title: value['title'] as String,
            completed: value['completed'] as bool,
          );
        }).toList();

        emit(TodoLoaded(todos: todos ?? []));
      });
    }
  }

  Future<void> addTodo({required String title}) async {
    try {
      final todo = Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        completed: false,
      );

      await _todoRef.child(todo.id).set(todo.toJson());
    } catch (e) {
      emit(TodoError(message: 'Failed to add todo'));
    }
  }

  Future<void> toggleTodoComplete({required Todo todo}) async {
    try {
      final updatedTodo = todo.copyWith(completed: !todo.completed);
      await _todoRef.child(updatedTodo.id).update(updatedTodo.toJson());
    } catch (e) {
      emit(TodoError(message: 'Failed to toggle todo complete status'));
    }
  }

  Future<void> deleteTodo({required Todo todo}) async {
    try {
      await _todoRef.child(todo.id).remove();
    } catch (e) {
      emit(TodoError(message: 'Failed to delete todo'));
    }
  }
}

class Todo {
  final String id;
  final String title;
  final bool completed;

  Todo({
    required this.id,
    required this.title,
    required this.completed,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'completed': completed,
    };
  }

  Todo copyWith({
    String? id,
    String? title,
    bool? completed,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}
