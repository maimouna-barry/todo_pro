import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';

import 'package:todo_pro/core/database/app_database.dart';
import 'package:todo_pro/features/todos/data/datasources/todo_local_data_source.dart';
import 'package:todo_pro/features/todos/data/repositories/todo_repository_impl.dart';
import 'package:todo_pro/features/todos/domain/entities/todo.dart' as domain;

void main() {
  late AppDatabase database;
  late TodoLocalDataSource dataSource;
  late TodoRepositoryImpl repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    dataSource = TodoLocalDataSource(database);
    repository = TodoRepositoryImpl(dataSource);
  });

  tearDown(() async {
    await database.close();
  });

  test('créer une todo', () async {
    final todo = domain.Todo(
      id: 0,
      title: 'Faire les courses',
      description: 'Acheter du lait',
      createdAt: DateTime(2026, 9, 15, 10, 0),
      scheduledAt: DateTime(2026, 9, 15, 18, 0),
      priority: domain.TodoPriority.high,
    );

    final id = await repository.createTodo(todo);

    expect(id, isPositive);
  });

  test('récupérer toutes les todos', () async {
    final todo = domain.Todo(
      id: 0,
      title: 'Faire les courses',
      createdAt: DateTime(2026, 9, 15, 10, 0),
      priority: domain.TodoPriority.high,
    );

    await repository.createTodo(todo);

    final todos = await repository.watchTodos().first;

    expect(todos, hasLength(1));
    expect(todos.first.title, 'Faire les courses');
  });

  test('récupérer une todo par son id', () async {
    final todo = domain.Todo(
      id: 0,
      title: 'Appeler ma famille',
      createdAt: DateTime(2026, 9, 15, 10, 0),
      priority: domain.TodoPriority.medium,
    );

    final id = await repository.createTodo(todo);

    final result = await repository.getTodo(id);

    expect(result, isNotNull);
    expect(result!.title, 'Appeler ma famille');
    expect(result.priority, domain.TodoPriority.medium);
  });

  test('récupérer null si la todo n’existe pas', () async {
    final result = await repository.getTodo(999);

    expect(result, isNull);
  });

  test('modifier une todo', () async {
    final todo = domain.Todo(
      id: 0,
      title: 'Ancien titre',
      description: 'Ancienne description',
      createdAt: DateTime(2026, 9, 15, 10, 0),
      priority: domain.TodoPriority.low,
    );

    final id = await repository.createTodo(todo);

    final updatedTodo = domain.Todo(
      id: id,
      title: 'Nouveau titre',
      description: 'Nouvelle description',
      createdAt: todo.createdAt,
      scheduledAt: DateTime(2026, 9, 15, 20, 0),
      priority: domain.TodoPriority.high,
    );

    await repository.updateTodo(updatedTodo);

    final result = await repository.getTodo(id);

    expect(result, isNotNull);
    expect(result!.title, 'Nouveau titre');
    expect(result.description, 'Nouvelle description');
    expect(result.scheduledAt, DateTime(2026, 9, 15, 20, 0));
    expect(result.priority, domain.TodoPriority.high);
  });

  test('supprimer une todo', () async {
    final todo = domain.Todo(
      id: 0,
      title: 'Todo à supprimer',
      createdAt: DateTime(2026, 9, 15, 10, 0),
      priority: domain.TodoPriority.low,
    );

    final id = await repository.createTodo(todo);

    await repository.deleteTodo(id);

    final result = await repository.getTodo(id);

    expect(result, isNull);
  });

  test('terminer une todo', () async {
    final todo = domain.Todo(
      id: 0,
      title: 'Todo à terminer',
      createdAt: DateTime(2026, 9, 15, 10, 0),
      priority: domain.TodoPriority.high,
    );

    final id = await repository.createTodo(todo);

    await repository.completedTodo(id);

    final result = await repository.getTodo(id);

    expect(result, isNotNull);
    expect(result!.completedAt, isNotNull);
  });
}
