import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtodo/controllers/auth_controller.dart';
import 'package:vtodo/navigation/routes.dart';
import '../controllers/todo_controller.dart';
import 'add_todo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.find<TodoController>();
    final AuthController authController = Get.find<AuthController>();

    // // Load todos from Hive
    // todoController.loadTodos();

    Color priorityColor(int priority) {
      switch (priority) {
        case 2:
          return Colors.red.shade400; // High
        case 1:
          return Colors.orange.shade400; // Medium
        default:
          return Colors.green.shade400; // Low
      }
    }

    return Scaffold(
      appBar: AppBar(
        title:  Text(
                'V TODO',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authController.logout();
              Get.offAllNamed(Routes.login);
            },
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              Get.isDarkMode
                  ? Get.changeThemeMode(ThemeMode.light)
                  : Get.changeThemeMode(ThemeMode.dark);
            },
          ),
        ],
      ),
      body: Obx(() {
        if (todoController.todos.isEmpty) {
          return const Center(child: Text('No Todos Added'));
        }

        return ListView.builder(
          itemCount: todoController.todos.length,
          itemBuilder: (context, index) {
            final todo = todoController.todos[index];

            return Dismissible(
              key: ValueKey(todo.key),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.red.shade400,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (_) => todoController.deleteTodo(todo.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (todo.isDone ?? false)
                      ? Colors.grey.shade800.withOpacity(0.7)
                      : Get.isDarkMode
                      ? Colors.grey.shade900
                      : Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Checkbox(
                    value: todo.isDone,
                    onChanged: (_) => todoController.toggleDone(todo.key),
                  ),
                  title: Text(
                    todo.title ?? 'Untitled',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: (todo.isDone ?? false)
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(todo.description ?? ''),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          if (todo.dueDate != null)
                            Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  '${todo.dueDate!.day}/${todo.dueDate!.month}/${todo.dueDate!.year}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: priorityColor(todo.priority ?? 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              todo.priority == 2
                                  ? 'High'
                                  : todo.priority == 1
                                  ? 'Medium'
                                  : 'Low',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Get.to(() => AddTodoScreen(editTodo: todo));
                    },
                  ),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutBack,
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: FloatingActionButton(
              onPressed: () => Get.to(() => const AddTodoScreen()),
              child: const Icon(Icons.add),
              tooltip: 'Add Todo',
            ),
          );
        },
      ),
    );
  }
}
