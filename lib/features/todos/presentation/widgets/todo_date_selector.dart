import 'package:flutter/material.dart';
import 'package:todo_pro/features/todos/presentation/providers/selected_date_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoDateSelector extends ConsumerWidget {
  const TodoDateSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    return SizedBox(
      height: 90,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                ...List.generate(7, (index) {
                  final date = selectedDate.add(Duration(days: index - 3));
                  final isSelected = DateUtils.isSameDay(date, selectedDate);

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        ref
                            .read(selectedDateProvider.notifier)
                            .selectDate(date);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            const [
                              'Lun',
                              'Mar',
                              'Mer',
                              'Jeu',
                              'Ven',
                              'Sam',
                              'Dim',
                            ][date.weekday - 1],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 36,
                            height: 36,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.transparent,
                              border: isSelected
                                  ? null
                                  : Border.all(color: Colors.grey.shade300),
                            ),
                            child: Text(
                              '${date.day}',
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(width: 4),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton.filledTonal(
              tooltip: 'Choisir une date',
              onPressed: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                  locale: const Locale('fr', 'FR'),
                );

                if (pickedDate != null && context.mounted) {
                  ref
                      .read(selectedDateProvider.notifier)
                      .selectDate(pickedDate);
                }
              },
              icon: const Icon(Icons.calendar_month_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
