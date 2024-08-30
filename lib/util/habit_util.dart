// Check if the habit is completed for the day

bool isHabitCompleted(List<DateTime> completedDates) {
  final today = DateTime.now();

  return completedDates.any(
    (date) =>
        date.year == today.year &&
        date.month == today.month &&
        date.day == today.day,
  );
}
