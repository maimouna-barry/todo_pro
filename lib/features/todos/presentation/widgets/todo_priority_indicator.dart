import 'package:flutter/material.dart';
import 'package:todo_pro/features/todos/domain/entities/todo.dart';

class TodoPriorityIndicator extends StatelessWidget {
  final TodoPriority priority;

  const TodoPriorityIndicator({super.key, required this.priority});

  @override
  Widget build(BuildContext context) {
    final (icon, color) = switch (priority) {
      TodoPriority.low => (Icons.keyboard_arrow_down, Colors.blue),
      TodoPriority.medium => (Icons.horizontal_rule, Colors.orange),
      TodoPriority.high => (Icons.keyboard_arrow_up, Colors.red),
    };

    return Icon(icon, color: color, size: 22);
  }
}
