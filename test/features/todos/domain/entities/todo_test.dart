import 'package:flutter_test/flutter_test.dart';
import 'package:todo_pro/features/todos/domain/entities/todo.dart';

void main() {
  test('Créer une tâche et vérifier ses propriétés', () {
    final createdAt = DateTime(2026, 9, 15, 15, 30);

    final todo = Todo(
      id: 1,
      title: 'Regarder THE GOF',
      createdAt: createdAt,
      priority: TodoPriority.medium,
    );

    expect(todo.id, 1);
    expect(todo.title, 'Regarder THE GOF');
    expect(todo.completedAt, isNull);
  });

  test('Créer une tâche terminée et vérifier sa date de complétion', () {
    final createdAt = DateTime(2026, 9, 15, 8, 30);
    final completedAt = DateTime(2026, 9, 15, 8, 50);

    final todo = Todo(
      id: 1,
      title: 'Faire ma toilette',
      createdAt: createdAt,
      priority: TodoPriority.medium,
      completedAt: completedAt,
    );

    expect(todo.id, 1);
    expect(todo.title, 'Faire ma toilette');
    expect(todo.completedAt, isNotNull);
  });
}
