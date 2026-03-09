import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtodo/widgets/app_button.dart';
import '../controllers/todo_controller.dart';
import '../models/todo_model.dart';

class AddTodoScreen extends StatefulWidget {
  final Todo? editTodo;
  const AddTodoScreen({super.key, this.editTodo});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  late TextEditingController titleController;
  late TextEditingController descController;
  final formKey = GlobalKey<FormState>();

  DateTime? selectedDueDate;
  int selectedPriority = 0; // 0=Low,1=Medium,2=High

  final TodoController todoController = Get.find();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.editTodo?.title ?? '');
    descController = TextEditingController(
      text: widget.editTodo?.description ?? '',
    );
    selectedDueDate = widget.editTodo?.dueDate ?? DateTime.now();
    selectedPriority = widget.editTodo?.priority ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.editTodo != null ? 'Edit Todo' : 'Add Todo',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Enter todo title' : null,
              ),
              const SizedBox(height: 20),

              // Description
              TextFormField(
                controller: descController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Enter description' : null,
              ),
              const SizedBox(height: 20),

              // Due Date Picker
              InkWell(
                onTap: _pickDueDate,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Due Date',
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    selectedDueDate != null
                        ? '${selectedDueDate!.day}/${selectedDueDate!.month}/${selectedDueDate!.year}'
                        : 'Select Date',
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Priority Selector
              DropdownButtonFormField<int>(
                value: selectedPriority,
                decoration: const InputDecoration(
                  labelText: 'Priority',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 0, child: Text('Low')),
                  DropdownMenuItem(value: 1, child: Text('Medium')),
                  DropdownMenuItem(value: 2, child: Text('High')),
                ],
                onChanged: (value) {
                  if (value != null) setState(() => selectedPriority = value);
                },
              ),
              const SizedBox(height: 30),

              // Add/Update Button
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  onTap: _saveTodo,
                  title: widget.editTodo != null ? 'Update Todo' : 'Add Todo',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickDueDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDueDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (date != null) setState(() => selectedDueDate = date);
  }

  void _saveTodo() {
    if (formKey.currentState!.validate() && selectedDueDate != null) {
      final title = titleController.text.trim();
      final description = descController.text.trim();

      if (widget.editTodo != null) {
        // Update existing todo
        final updatedTodo = widget.editTodo!.copyWith(
          title: title,
          description: description,
          dueDate: selectedDueDate,
          priority: selectedPriority,
        );
        todoController.updateTodo(widget.editTodo!.key as int, updatedTodo);
      } else {
        // Add new todo
        final newTodo = Todo(
          title: title,
          description: description,
          userEmail: 'demo@example.com', // Replace with current user email
          dueDate: selectedDueDate!,
          priority: selectedPriority,
        );
        todoController.addTodo(newTodo);
      }
      Get.back();
    } else {
      Get.snackbar(
        'Error',
        'Please fill all fields and select due date',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }
}
