import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  String? title;

  @HiveField(1)
  String? description;

  @HiveField(2)
  bool? isDone;

  @HiveField(3)
  int? priority; // 0=Low,1=Medium,2=High

  @HiveField(4)
  DateTime? createdAt;

  @HiveField(5)
  String? userEmail;
  @HiveField(6)
  DateTime? dueDate;

  Todo({
     this.title,
     this.description,
     this.userEmail,
     this.dueDate,
    this.isDone = false,
    this.priority = 0,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
  Todo copyWith({
    String? title,
    String? description,
    bool? isDone,
    int? priority,
    DateTime? createdAt,
    String? userEmail,
    DateTime? dueDate,
  }) {
    return Todo(
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      userEmail: userEmail ?? this.userEmail,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}