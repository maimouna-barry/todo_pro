import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_pro/features/todos/presentation/providers/todo_providers.dart';
import 'package:todo_pro/features/todos/presentation/widgets/todo_header.dart';
import 'package:todo_pro/features/todos/presentation/widgets/todo_list.dart';
import 'package:todo_pro/features/todos/presentation/widgets/todo_date_selector.dart';
import 'package:todo_pro/features/todos/presentation/providers/selected_date_provider.dart';

class TodoListPage extends ConsumerWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsync = ref.watch(todosProvider);
    final selectedDate = ref.watch(selectedDateProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TodoHeader(),
            const TodoDateSelector(),
            Expanded(
              child: todosAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) =>
                    const Center(child: Text('Une erreur est survenue.')),
                data: (todos) {
                  final filteredTodos = todos.where((todo) {
                    final scheduledAt = todo.scheduledAt;

                    return scheduledAt != null &&
                        DateUtils.isSameDay(scheduledAt, selectedDate);
                  }).toList();

                  return TodoList(todos: filteredTodos);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
