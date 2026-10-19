import 'package:flutter/material.dart';

class TodoDateSelector extends StatefulWidget {
  const TodoDateSelector({super.key});

  @override
  State<TodoDateSelector> createState() => _TodoDateSelectorState();
}

class _TodoDateSelectorState extends State<TodoDateSelector> {
  DateTime selectedDate = DateUtils.dateOnly(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final today = DateUtils.dateOnly(DateTime.now());

    return SizedBox(
      height: 90,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                ...List.generate(7, (index) {
                  final date = today.add(Duration(days: index - 3));
                  final isSelected = DateUtils.isSameDay(date, selectedDate);

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDate = date;
                        });
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
                  setState(() {
                    selectedDate = DateUtils.dateOnly(pickedDate);
                  });
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
