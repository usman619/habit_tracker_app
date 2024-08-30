import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habit_tracker_app/themes/text_theme.dart';

class MyHabitTile extends StatelessWidget {
  final String text;
  final bool isCompleted;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext context)? editHabit;
  final void Function(BuildContext context)? deleteHabit;
  const MyHabitTile({
    super.key,
    required this.text,
    required this.isCompleted,
    required this.onChanged,
    required this.editHabit,
    required this.deleteHabit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: editHabit,
              icon: Icons.edit,
              backgroundColor: Colors.grey.shade500,
              borderRadius: BorderRadius.circular(8),
            ),
            SlidableAction(
              onPressed: deleteHabit,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            if (onChanged != null) {
              onChanged!(!isCompleted);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isCompleted
                  ? Colors.green
                  : Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                text,
                style: bodyTextTheme.copyWith(
                  color: isCompleted
                      ? Colors.white
                      : Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              leading: Checkbox(
                value: isCompleted,
                onChanged: onChanged,
                activeColor: Colors.green,
                checkColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
