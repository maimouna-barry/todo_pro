import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_pro/features/todos/presentation/providers/todo_providers.dart';
import 'package:todo_pro/features/todos/presentation/widgets/todo_header.dart';
import 'package:todo_pro/features/todos/presentation/widgets/todo_list.dart';

class TodoListPage extends ConsumerWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsync = ref.watch(todosProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TodoHeader(),
            Expanded(
              child: todosAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) =>
                    const Center(child: Text('Une erreur est survenue.')),
                data: (todos) => TodoList(todos: todos),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
