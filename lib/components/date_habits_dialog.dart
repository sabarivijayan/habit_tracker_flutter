import 'package:flutter/material.dart';
import 'package:habit_tracker_2/models/habit.dart';

class DateHabitsDialog extends StatelessWidget {
  final DateTime date;
  final List<Habit> habits;

  const DateHabitsDialog({
    super.key, 
    required this.date, 
    required this.habits
  });

  @override
  Widget build(BuildContext context) {
    // Filter habits completed on the specific date
    final completedHabits = habits.where((habit) => 
      habit.completedDays.any((completedDate) => 
        completedDate.year == date.year &&
        completedDate.month == date.month &&
        completedDate.day == date.day
      )
    ).toList();

    return AlertDialog(
      title: Text('Habits on ${date.toLocal().toString().split(' ')[0]}'),
      content: completedHabits.isEmpty
        ? Text('No habits completed on this day.')
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: completedHabits.map((habit) => 
              ListTile(
                title: Text(habit.name),
                leading: Icon(Icons.check_circle, color: Colors.green),
              )
            ).toList(),
          ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Close'),
        )
      ],
    );
  }
}