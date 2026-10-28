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

  test('créer une tâchee et la récupérer', () async {
    final todo1 = domain.Todo(
      id: 1,
      title: 'Marcher pendant 10min',
      createdAt: DateTime(2026, 9, 11, 12, 19),
      scheduledAt: DateTime(2026, 9, 11, 20, 30),
      priority: domain.TodoPriority.high,
    );

    await dataSource.createTodo(todo1);

    final result = await dataSource.getTodo(todo1.id);

    expect(result!.title, 'Marcher pendant 10min');
  });

  test('récupérer une todo existante par son id', () async {
    final todo = domain.Todo(
      id: 1,
      title: 'Faire les courses',
      description: 'Acheter du lait',
      createdAt: DateTime(2026, 9, 15, 10, 0),
      scheduledAt: DateTime(2026, 9, 15, 18, 0),
      priority: domain.TodoPriority.high,
    );

    final id = await dataSource.createTodo(todo);

    final result = await dataSource.getTodo(id);

    expect(result, isNotNull);
    expect(result!.title, 'Faire les courses');
    expect(result.description, 'Acheter du lait');
    expect(result.priority, domain.TodoPriority.high);
  });

  test('retourner null si la todo n’existe pas', () async {
    final result = await dataSource.getTodo(999);

    expect(result, isNull);
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
    final todo = await dataSource.getTodo(todoModifiee.id);

    expect(todo?.title, 'Allez en ville');
    expect(todo?.scheduledAt, DateTime(2026, 9, 19, 9, 0));
    expect(todo?.priority, domain.TodoPriority.high);
  });

  test('Supprimer une todo existante', () async {
    final todoCree = domain.Todo(
      id: 1,
      title: 'Regarder the Vikings',
      createdAt: DateTime(2017, 9, 7, 17, 30),
      scheduledAt: DateTime(2017, 9, 13, 20, 30),
      priority: domain.TodoPriority.low,
    );

    await dataSource.createTodo(todoCree);
    await dataSource.deleteTodo(todoCree.id);
    final todo = await dataSource.getTodo(todoCree.id);

    expect(todo, isNull);
  });

  test("terminer une tàche", () async {
    final todoBase = domain.Todo(
      id: 1,
      title: 'Manger',
      createdAt: DateTime(2017, 9, 13, 20, 30),
      priority: domain.TodoPriority.high,
    );

    await dataSource.createTodo(todoBase);
    await dataSource.completedTodo(todoBase.id);

    final todoCompleted = await dataSource.getTodo(todoBase.id);

    expect(todoCompleted!.completedAt, isNotNull);
  });

  tearDown(() async {
    await database.close();
  });
}
