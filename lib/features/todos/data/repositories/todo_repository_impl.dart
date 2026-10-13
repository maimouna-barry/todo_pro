import 'package:todo_pro/features/todos/data/datasources/todo_local_data_source.dart';
import 'package:todo_pro/features/todos/domain/entities/todo.dart';
import 'package:todo_pro/features/todos/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource dataSource;

  TodoRepositoryImpl(this.dataSource);

  @override
  Future<Todo?> getTodo(int id) {
    return dataSource.getTodo(id);
  }

  @override
  Future<int> createTodo(Todo todo) {
    return dataSource.createTodo(todo);
  }

  @override
  Future<void> updateTodo(Todo todo) {
    return dataSource.updateTodo(todo);
  }

  @override
  Future<void> deleteTodo(int id) {
    return dataSource.deleteTodo(id);
  }

  @override
  Future<void> completedTodo(int id) {
    return dataSource.completedTodo(id);
  }

  @override
  Stream<List<Todo>> watchTodos() {
    return dataSource.watchTodos();
  }
}
