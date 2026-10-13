import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_pro/features/todos/presentation/providers/todo_providers.dart';
import 'package:todo_pro/features/todos/presentation/widgets/todo_item.dart';

class TodoListPage extends ConsumerWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsync = ref.watch(todosProvider);
    return Scaffold(
      body: todosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            const Center(child: Text('Une erreur est survenue.')),
        data: (todos) {
          if (todos.isEmpty) {
            return const Center(child: Text('Aucune Todo'));
          }

          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];

              return TodoItem(todo: todo);
            },
          );
        },
      ),
    );
  }
}
