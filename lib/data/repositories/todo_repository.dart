import '../../core/database/database_helper.dart';
import '../models/todo_model.dart';

class TodoRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<List<TodoModel>> getTodos() async {
    return await _dbHelper.fetchTodos();
  }

  Future<int> addTodo(TodoModel todo) async {
    return await _dbHelper.insertTodo(todo);
  }

  Future<int> updateTodo(TodoModel todo) async {
    return await _dbHelper.updateTodo(todo);
  }

  Future<int> deleteTodo(int id) async {
    return await _dbHelper.deleteTodo(id);
  }
}