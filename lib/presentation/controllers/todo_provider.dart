import 'package:flutter/foundation.dart';
import '../../data/models/todo_model.dart';
import '../../core/database/database_helper.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoModel> _todos = [];
  bool _isLoading = false;

  List<TodoModel> get todos => _todos;
  bool get isLoading => _isLoading;

  Future<void> loadTodos() async {
    _isLoading = true;
    notifyListeners();

    _todos = await DatabaseHelper.instance.fetchTodos();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTodo(TodoModel todo) async {
    await DatabaseHelper.instance.insertTodo(todo);
    await loadTodos();
  }

  Future<void> updateTodoStatus(TodoModel todo) async {
    final updated = todo.copyWith(isCompleted: !todo.isCompleted);
    await DatabaseHelper.instance.updateTodo(updated);
    await loadTodos();
  }

  Future<void> deleteTodo(int id) async {
    await DatabaseHelper.instance.deleteTodo(id);
    await loadTodos();
  }
}