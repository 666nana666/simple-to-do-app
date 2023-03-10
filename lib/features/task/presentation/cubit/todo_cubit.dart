import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

part 'todo_state.dart';

@Injectable()
class TodoCubit extends Cubit<TodoState> {
  late DatabaseReference _todoRef;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TodoCubit() : super(TodoInitial());

  void getUser(){
    final User? user = _auth.currentUser;
    print("test${user?.uid}");
    if (user != null) {
      _todoRef = FirebaseDatabase.instance
          .reference()
          .child('users/${user.uid}/todos');
      _todoRef.onValue.listen((event) {
        final data = event.snapshot.value as Map<dynamic, dynamic>?;
        final todos = data?.entries.map((e) {
          final key = e.key as String;
          final value = e.value as Map<dynamic, dynamic>;
          return Todo(
            id: key,
            time: value['time'] ??
                DateFormat('HH.mm d , MMM y').format(DateTime.now()),
            title: value['title'] as String,
            completed: value['completed'] as bool,
          );
        }).toList();

        emit(TodoLoaded(todos: todos ?? []));
      });
    }else{

    }}
  Future<void> addTodo({required String title}) async {
    print("error $title");
    try {
      final todo = Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        time: DateFormat('HH.mm d , MMM y').format(DateTime.now()),
        completed: false,
      );
      print(todo.toJson());
      await _todoRef.child(todo.id).set(todo.toJson());
    } catch (e) {
      print("error $e");
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
  final String time;
  final bool completed;

  Todo({
    required this.id,
    required this.time,
    required this.title,
    required this.completed,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'time': time,
      'completed': completed,
    };
  }

  Todo copyWith({
    String? id,
    String? title,
    String? time,
    bool? completed,
  }) {
    return Todo(
      id: id ?? this.id,
      time: time ?? this.time,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}
