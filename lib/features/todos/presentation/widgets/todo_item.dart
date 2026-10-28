import 'package:flutter/material.dart';
import 'package:todo_pro/features/todos/domain/entities/todo.dart';
import 'package:todo_pro/features/todos/presentation/widgets/todo_priority_indicator.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  const TodoItem({super.key, required this.todo});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF1C1C1E),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 99,
            decoration: BoxDecoration(
              color: todo.completedAt == null ? Colors.blue : Colors.green,
            ),
          ),
          const SizedBox(height: 6),
          Checkbox(
            value: todo.completedAt != null,
            onChanged: (value) {},
            checkColor: Colors.white,
            activeColor: Colors.green,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    todo.title,
                    style: TextStyle(
                      color: todo.completedAt != null
                          ? Colors.grey
                          : Colors.white,
                      decoration: todo.completedAt != null
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    todo.scheduledAt == null
                        ? 'Aucune heure prévue'
                        : '${todo.scheduledAt!.hour.toString().padLeft(2, '0')}:${todo.scheduledAt!.minute.toString().padLeft(2, '0')}',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          TodoPriorityIndicator(priority: todo.priority),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}
