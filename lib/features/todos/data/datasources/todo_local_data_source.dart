import 'package:drift/drift.dart';
import 'package:todo_pro/core/database/app_database.dart';
import 'package:todo_pro/features/todos/domain/entities/todo.dart' as domain;

class TodoLocalDataSource {
  final AppDatabase database;

  const TodoLocalDataSource(this.database);

  Future<List<domain.Todo>> getTodos() async {
    final rows = await database.select(database.todos).get();

    return rows.map((row) {
      return domain.Todo(
        id: row.id,
        title: row.title,
        description: row.description,
        createdAt: row.createdAt,
        scheduledAt: row.scheduledAt,
        priority: domain.TodoPriority.values.byName(row.priority),
      );
    }).toList();
  }

  Future<int> createTodo(domain.Todo todo) async {
    final companion = TodosCompanion(
      title: Value(todo.title),
      description: Value(todo.description),
      scheduledAt: Value(todo.scheduledAt),
      createdAt: Value(todo.createdAt),
      completedAt: Value(todo.completedAt),
      priority: Value(todo.priority.name),
    );

    return await database.into(database.todos).insert(companion);
  }
}
