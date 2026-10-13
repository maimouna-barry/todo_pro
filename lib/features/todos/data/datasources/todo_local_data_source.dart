import 'package:drift/drift.dart';
import 'package:todo_pro/core/database/app_database.dart';
import 'package:todo_pro/features/todos/domain/entities/todo.dart' as domain;

class TodoLocalDataSource {
  final AppDatabase database;

  const TodoLocalDataSource(this.database);

  Stream<List<domain.Todo>> watchTodos() {
    final rows = database.select(database.todos).watch();

    return rows.map((rows) {
      return rows.map((row) {
        return domain.Todo(
          id: row.id,
          title: row.title,
          description: row.description,
          createdAt: row.createdAt,
          scheduledAt: row.scheduledAt,
          completedAt: row.completedAt,
          priority: domain.TodoPriority.values.byName(row.priority),
        );
      }).toList();
    });
  }

  Future<domain.Todo?> getTodo(int id) async {
    final result = await (database.select(
      database.todos,
    )..where((table) => table.id.equals(id))).get();

    if (result.isEmpty) {
      return null;
    }

    final row = result.first;

    return domain.Todo(
      id: row.id,
      title: row.title,
      description: row.description,
      createdAt: row.createdAt,
      scheduledAt: row.scheduledAt,
      completedAt: row.completedAt,
      priority: domain.TodoPriority.values.byName(row.priority),
    );
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

  Future<void> updateTodo(domain.Todo todo) async {
    final companion = TodosCompanion(
      title: Value(todo.title),
      description: Value(todo.description),
      scheduledAt: Value(todo.scheduledAt),
      priority: Value(todo.priority.name),
    );

    await (database.update(
      database.todos,
    )..where((table) => table.id.equals(todo.id))).write(companion);
  }

  Future<void> deleteTodo(int id) async {
    await (database.delete(
      database.todos,
    )..where((table) => table.id.equals(id))).go();
  }

  Future<void> completedTodo(int id) async {
    await (database.update(database.todos)
          ..where((table) => table.id.equals(id)))
        .write(TodosCompanion(completedAt: Value(DateTime.now())));
  }
}
