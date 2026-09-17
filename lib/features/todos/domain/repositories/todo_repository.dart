import 'package:todo_pro/features/todos/domain/entities/todo.dart';

abstract class TodoRepository {
  Stream<List<Todo>> watchTodos();

  Future<Todo?> getTodo(int id);

  Future<void> createTodo(Todo todo);

  Future<void> updateTodo(Todo todo);

  Future<void> deleteTodo(int id);

  Future<void> completedTodo(int id);
}
