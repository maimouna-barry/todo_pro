import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_pro/core/database/database_connection.dart';
import 'package:todo_pro/core/database/app_database.dart';
import 'package:todo_pro/features/todos/data/datasources/todo_local_data_source.dart';
import 'package:todo_pro/features/todos/data/repositories/todo_repository_impl.dart';
import 'package:todo_pro/features/todos/domain/entities/todo.dart' as domain;
import 'package:todo_pro/features/todos/domain/repositories/todo_repository.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase(openDatabaseConnection());

  ref.onDispose(database.close);

  return database;
});

final todoLocalDataSourceProvider = Provider<TodoLocalDataSource>((ref) {
  final database = ref.watch(databaseProvider);

  return TodoLocalDataSource(database);
});

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  final dataSource = ref.watch(todoLocalDataSourceProvider);

  return TodoRepositoryImpl(dataSource);
});

final todosProvider = StreamProvider<List<domain.Todo>>((ref) {
  final repository = ref.watch(todoRepositoryProvider);

  return repository.watchTodos();
});
