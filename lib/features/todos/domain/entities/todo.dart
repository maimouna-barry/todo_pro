import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';

enum TodoPriority { low, medium, high }

@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    required int id,
    required String title,
    String? description,
    required DateTime createdAt,
    DateTime? scheduledAt,
    DateTime? completedAt,
    required TodoPriority priority,
  }) = _Todo;
}
