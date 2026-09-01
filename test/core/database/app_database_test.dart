import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:todo_pro/core/database/app_database.dart';

void main() {
  late AppDatabase dataBase ;
  setUp(() {
    dataBase = AppDatabase(NativeDatabase.memory());
  });

  test('insérer puis récupérer une Todo', () async {
    final todo = await dataBase.into(dataBase.todos).insertReturning(
      TodosCompanion.insert(
        title: 'Lire pendant 10m',
        priority: 'medium',
        createdAt:DateTime.now(),
      )
    );
    expect(todo.title, 'Lire pendant 10m');
    expect(todo.isCompleted, false);
  });

  tearDown(() async {
    dataBase.close();
  }); 
}