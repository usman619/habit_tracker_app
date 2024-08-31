// Check if the habit is completed for the day
import 'package:habit_tracker_app/models/habit.dart';

bool isHabitCompleted(List<DateTime> completedDates) {
  final today = DateTime.now();

  return completedDates.any(
    (date) =>
        date.year == today.year &&
        date.month == today.month &&
        date.day == today.day,
  );
}

// Prepare Heat Map dataset

Map<DateTime, int> prepareHeatMapDataset(List<Habit> habits) {
  Map<DateTime, int> dataset = {};

  for (var habit in habits) {
    for (var date in habit.completedDays) {
      // Normalize the date to remove the time part
      final normalizedDate = DateTime(date.year, date.month, date.day);
      // Check if the date is already in the dataset and increment the count
      if (dataset.containsKey(normalizedDate)) {
        dataset[normalizedDate] = dataset[normalizedDate]! + 1;
      } else {
        // Initialize it with count of 1
        dataset[normalizedDate] = 1;
      }
    }
  }
  return dataset;
}
