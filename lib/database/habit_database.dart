import 'package:flutter/material.dart';
import 'package:habit_tracker_app/models/app_settings.dart';
import 'package:habit_tracker_app/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;

  static Future<void> intialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [HabitSchema, AppSettingsSchema],
      directory: dir.path,
    );
  }

  // Save the launch date of the app for the heatmap
  Future<void> saveFirstLaunch() async {
    final existSettings = await isar.appSettings.where().findFirst();
    if (existSettings == null) {
      final settings = AppSettings()..firstOpen = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

  // Get the launch date of the app
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstOpen;
  }

  // H A B I T S
  List<Habit> currentHabits = [];
  // Add a new habit
  Future<void> addHabit(String habitName) async {
    final habit = Habit()..name = habitName;
    await isar.writeTxn(() => isar.habits.put(habit));
    readHabits();
  }

  // Read Habits
  Future<void> readHabits() async {
    List<Habit> fetchedHabits = await isar.habits.where().findAll();
    currentHabits.clear();
    currentHabits.addAll(fetchedHabits);

    // Update UI
    notifyListeners();
  }

  // Update Habit Completion
  Future<void> updateHabitCompletion(int habitId, bool isCompleted) async {
    final habit = await isar.habits.get(habitId);
    if (habit != null) {
      await isar.writeTxn(
        () async {
          // If the habit is completed for the day, add it current habit to completedDates
          if (isCompleted && !habit.completedDates.contains(DateTime.now())) {
            final today = DateTime.now();
            habit.completedDates.add(
              DateTime(
                today.day,
                today.month,
                today.year,
              ),
            );
          } else {
            // Else remove the tody's date date from completedDates
            habit.completedDates.removeWhere(
              (date) =>
                  date.day == DateTime.now().day &&
                  date.month == DateTime.now().month &&
                  date.year == DateTime.now().year,
            );
          }
        },
      );
    }
  }

  // Update Habit Name
  Future<void> updateHabitName(int id, String newName) async {
    final habit = await isar.habits.get(id);
    if (habit != null) {
      habit.name = newName;
      await isar.writeTxn(
        () async {
          await isar.habits.put(habit);
        },
      );
    }
    readHabits();
  }

  // Delete Habit
  Future<void> deleteHabit(int id) async {
    await isar.writeTxn(
      () async {
        await isar.habits.delete(id);
      },
    );
    readHabits();
  }
}
