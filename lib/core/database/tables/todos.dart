import 'package:drift/drift.dart';

class Todos extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get scheduledAt => dateTime().nullable()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  TextColumn get priority => text()();
  BoolColumn get isCompleted => 
    boolean().withDefault(const Constant(false))();
}