import 'package:flutter/material.dart';
import 'package:habit_tracker_app/components/my_drawer.dart';
import 'package:habit_tracker_app/components/my_habit_tile.dart';
import 'package:habit_tracker_app/database/habit_database.dart';
import 'package:habit_tracker_app/models/habit.dart';
import 'package:habit_tracker_app/themes/text_theme.dart';
import 'package:habit_tracker_app/util/habit_util.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController habitController = TextEditingController();
  @override
  void initState() {
    Provider.of<HabitDatabase>(context, listen: false).readHabits();
    super.initState();
  }

  // Create a new habit
  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create a new Habit', style: bodyTextTheme),
        content: TextField(
          controller: habitController,
          decoration: InputDecoration(
            hintText: 'Habit Name',
            hintStyle: bodyTextTheme,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              habitController.clear();
            },
            child: Text(
              'Cancel',
              style: bodyTextTheme.copyWith(
                  color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<HabitDatabase>().addHabit(habitController.text);
              habitController.clear();
            },
            child: Text(
              'Save',
              style: bodyTextTheme.copyWith(
                  color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // Check off the habit for the day
  void checkOffHabit(bool? value, Habit habit) {
    if (value != null) {
      context.read<HabitDatabase>().updateHabitCompletion(habit.id, value);
    }
    setState(() {});
  }

  // Edit the habit
  void editHabit(Habit habit) {
    habitController.text = habit.name;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Habit', style: bodyTextTheme),
        content: TextField(
          controller: habitController..text = habit.name,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              habitController.clear();
            },
            child: Text(
              'Cancel',
              style: bodyTextTheme.copyWith(
                  color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context
                  .read<HabitDatabase>()
                  .updateHabitName(habit.id, habitController.text);
              habitController.clear();
            },
            child: Text(
              'Save',
              style: bodyTextTheme.copyWith(
                  color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // Delete the habit
  void deleteHabit(Habit habit) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                'Delete Habit',
                style: titleTextTheme.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              content: Text(
                'Are you sure you want to delete "${habit.name}"?',
                style: bodyTextTheme,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: bodyTextTheme.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.read<HabitDatabase>().deleteHabit(habit.id);
                  },
                  child: Text(
                    'Delete',
                    style: bodyTextTheme.copyWith(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: titleTextTheme,
        ),
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const MyDrawer(),
      body: _buildHabitList(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        focusColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add_task_sharp),
      ),
    );
  }

  Widget _buildHabitList() {
    final habitsDatabase = context.watch<HabitDatabase>();
    final habits = habitsDatabase.currentHabits;

    return ListView.builder(
      itemCount: habits.length,
      itemBuilder: (context, index) {
        final habit = habits[index];
        bool isCompletedToday = isHabitCompleted(habit.completedDays);
        return MyHabitTile(
          text: habit.name,
          isCompleted: isCompletedToday,
          onChanged: (isCompletedToday) =>
              checkOffHabit(isCompletedToday, habit),
          editHabit: (context) => editHabit(habit),
          deleteHabit: (context) => deleteHabit(habit),
        );
      },
    );
  }
}
