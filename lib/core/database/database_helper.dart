import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/todo_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  DatabaseHelper._init();

  static const String _storageKey = 'todos_data_key';

  Future<List<TodoModel>> fetchTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_storageKey);

    // Print this to see if data actually exists in storage!
    print('RAW JSON FROM STORAGE: $jsonString');

    if (jsonString == null) return [];

    try {
      final List decoded = jsonDecode(jsonString);
      return decoded.map((item) => TodoModel.fromMap(item)).toList();
    } catch (e) {
      print('ERROR DECODING TODOS: $e'); // <--- See what failed here
      return [];
    }
  }

  Future<int> insertTodo(TodoModel todo) async {
    final todos = await fetchTodos();
    final newId = DateTime.now().millisecondsSinceEpoch;
    final newTodo = todo.copyWith(id: newId);
    todos.insert(0, newTodo);
    await _saveAll(todos);
    return newId;
  }

  Future<int> updateTodo(TodoModel todo) async {
    final todos = await fetchTodos();
    final index = todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      todos[index] = todo;
      await _saveAll(todos);
      return 1;
    }
    return 0;
  }

  Future<int> deleteTodo(int id) async {
    final todos = await fetchTodos();
    todos.removeWhere((t) => t.id == id);
    await _saveAll(todos);
    return 1;
  }

  Future<void> _saveAll(List<TodoModel> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(todos.map((t) => t.toMap()).toList());
    await prefs.setString(_storageKey, encoded);
  }
}