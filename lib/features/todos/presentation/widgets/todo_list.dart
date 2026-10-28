import 'package:flutter/material.dart';
import 'package:todo_pro/features/todos/domain/entities/todo.dart';
import 'package:todo_pro/features/todos/presentation/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key, required this.todos});

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Center(child: Text('Aucune Todo'));
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return TodoItem(todo: todos[index]);
      },
    );
  }
}
