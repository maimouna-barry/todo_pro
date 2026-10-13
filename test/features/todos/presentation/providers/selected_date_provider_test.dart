import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todo_pro/features/todos/presentation/providers/selected_date_provider.dart';

void main() {
  test('la date sélectionnée peut être modifiée', () {
    final container = ProviderContainer();

    final date = DateTime(2026, 10, 6);

    container.read(selectedDateProvider.notifier).selectDate(date);

    final selectedDate = container.read(selectedDateProvider);

    expect(selectedDate, date);
  });
}
