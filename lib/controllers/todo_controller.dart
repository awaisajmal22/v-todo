import 'package:get/get.dart';
import 'package:vtodo/services/todo_services.dart';
import '../models/todo_model.dart';

class TodoController extends GetxController {
  final TodoService _todoService = TodoService();

  // Reactive list of todos
  var todos = <Todo>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadTodos();
  }

  // Load todos from Hive
  Future<void> _loadTodos() async {
    await _todoService.init();
    final loadedTodos = await _todoService.getTodos();
    todos.assignAll(loadedTodos);
  }

  // Add a new todo
  Future<void> addTodo(Todo todo) async {
    await _todoService.addTodo(todo);
    todos.add(todo);
  }

  // Update a todo by index
  Future<void> updateTodo(int index, Todo updatedTodo) async {
    await _todoService.updateTodo(index, updatedTodo);
    todos[index] = updatedTodo;
    todos.refresh(); // notify listeners
  }

  // Delete a todo by index
  Future<void> deleteTodo(int index) async {
    await _todoService.deleteTodo(index);
    todos.removeAt(index);
  }
  Future<void> toggleDone(int index) async {
    final todo = todos[index];
    final updatedTodo = todo.copyWith(isDone: !(todo.isDone ?? false));
    await _todoService.updateTodo(index, updatedTodo);
    todos[index] = updatedTodo;
    todos.refresh();
  }
}