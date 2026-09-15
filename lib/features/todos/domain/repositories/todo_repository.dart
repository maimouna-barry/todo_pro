import 'package:todo_pro/features/todos/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodos();

  Future<Todo?> getTodo(int id);

  Future<int> createTodo(Todo todo);

  Future<void> updateTodo(Todo todo);

  Future<void> deleteTodo(int id);

  Future<void> completedTodo(int id);
}
