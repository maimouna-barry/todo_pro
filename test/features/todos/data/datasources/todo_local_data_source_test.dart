import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todo_pro/core/database/app_database.dart';
import 'package:todo_pro/features/todos/data/datasources/todo_local_data_source.dart';
import 'package:todo_pro/features/todos/domain/entities/todo.dart' as domain;

void main() {
  late AppDatabase database;
  late TodoLocalDataSource dataSource;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    dataSource = TodoLocalDataSource(database);
  });

  test('créer des tâches et les récupérer', () async {
    final todo1 = domain.Todo(
      id: 1,
      title: 'Marcher pendant 10min',
      createdAt: DateTime(2026, 9, 11, 12, 19),
      scheduledAt: DateTime(2026, 9, 11, 20, 30),
      priority: domain.TodoPriority.high,
    );

    final todo2 = domain.Todo(
      id: 2,
      title: 'Appellez ma GF',
      createdAt: DateTime(2026, 9, 11, 20, 30),
      scheduledAt: DateTime(2026, 9, 12, 20, 30),
      priority: domain.TodoPriority.medium,
    );

    await dataSource.createTodo(todo1);
    await dataSource.createTodo(todo2);

    final results = await dataSource.getTodos();
    final titres = results.map((result) => result.title).toList();
    expect(results.length, 2);
    expect(results[1].priority, todo2.priority);
    expect(titres, contains(todo1.title));
    expect(titres, contains(todo2.title));
  });

  test('Modifier une todo existante', () async {
    final todoBase = domain.Todo(
      id: 1,
      title: 'Faire le linge',
      createdAt: DateTime(2026, 9, 15, 9, 0),
      scheduledAt: DateTime(2026, 9, 19, 9, 0),
      priority: domain.TodoPriority.medium,
    );

    await dataSource.createTodo(todoBase);

    final todoModifiee = todoBase.copyWith(
      title: 'Allez en ville',
      scheduledAt: DateTime(2026, 9, 19, 9, 0),
      priority: domain.TodoPriority.high,
    );

    await dataSource.updateTodo(todoModifiee);
    final todos = await dataSource.getTodos();

    expect(todos, hasLength(1));
    expect(todos.first.title, 'Allez en ville');
    expect(todos.first.scheduledAt, DateTime(2026, 9, 19, 9, 0));
    expect(todos.first.priority, domain.TodoPriority.high);
  });

  test('Supprimer une todo existante', () async {
    final todo = domain.Todo(
      id: 1,
      title: 'Regarder the Vikings',
      createdAt: DateTime(2017, 9, 7, 17, 30),
      scheduledAt: DateTime(2017, 9, 13, 20, 30),
      priority: domain.TodoPriority.low,
    );

    final todoCree = await dataSource.createTodo(todo);
    await dataSource.deleteTodo(todoCree);
    final todos = await dataSource.getTodos();

    expect(todos, hasLength(0));
  });

  tearDown(() async {
    await database.close();
  });
}
