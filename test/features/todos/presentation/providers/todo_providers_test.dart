import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todo_pro/core/database/app_database.dart';
import 'package:todo_pro/features/todos/domain/entities/todo.dart' as domain;
import 'package:todo_pro/features/todos/presentation/providers/todo_providers.dart';

void main() {
  late AppDatabase database;
  late ProviderContainer container;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());

    container = ProviderContainer(
      overrides: [databaseProvider.overrideWithValue(database)],
    );
  });

  tearDown(() async {
    container.dispose();
    await database.close();
  });

  test('todosProvider retourne les todos enregistrées en base', () async {
    final result = container.listen(
      todosProvider,
      (_, next) {},
      fireImmediately: true,
    );

    await container
        .read(todoRepositoryProvider)
        .createTodo(
          domain.Todo(
            id: 1,
            title: 'Faire les courses',
            createdAt: DateTime(2026, 9, 30, 10),
            priority: domain.TodoPriority.high,
          ),
        );

    await Future<void>.delayed(const Duration(milliseconds: 100));

    final value = result.read();

    expect(value.hasValue, isTrue);
    expect(value.value, hasLength(1));
    expect(value.value!.first.title, 'Faire les courses');
    expect(value.value!.first.priority, domain.TodoPriority.high);

    result.close();
  });
}
