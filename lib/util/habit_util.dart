// Check if the habit is completed for the day

bool isHabitCompleted(List<DateTime> completedDates) {
  final today = DateTime.now();

  return completedDates.any(
    (date) =>
        date.day == today.day &&
        date.month == today.month &&
        date.year == today.year,
  );
}
