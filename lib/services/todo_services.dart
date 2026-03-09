import 'package:hive/hive.dart';
import '../models/todo_model.dart';

class TodoService {
  static const String _todoBoxName = 'todos';

  Future<void> init() async {
    await Hive.openBox<Todo>(_todoBoxName);
  }

  Future<void> addTodo(Todo todo) async {
    final box = Hive.box<Todo>(_todoBoxName);
    await box.add(todo);
  }

  Future<List<Todo>> getTodos() async {
    final box = Hive.box<Todo>(_todoBoxName);
    return box.values.toList();
  }

  Future<void> updateTodo(int index, Todo updatedTodo) async {
    final box = Hive.box<Todo>(_todoBoxName);
    await box.putAt(index, updatedTodo);
  }

  Future<void> deleteTodo(int index) async {
    final box = Hive.box<Todo>(_todoBoxName);
    await box.deleteAt(index);
  }
}