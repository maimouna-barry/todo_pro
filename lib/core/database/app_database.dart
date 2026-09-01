import 'package:drift/drift.dart';

import 'tables/todos.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Todos])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override 
  int get schemaVersion => 1 ;
}
