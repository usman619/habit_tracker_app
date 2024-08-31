import 'package:flutter/material.dart';
import 'package:habit_tracker_app/database/habit_database.dart';
import 'package:habit_tracker_app/pages/home_page.dart';
import 'package:habit_tracker_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Isar Datebase
  await HabitDatabase.intialize();
  await HabitDatabase().saveFirstLaunch();

  runApp(
    MultiProvider(
      providers: [
        //Habit Database Provider
        ChangeNotifierProvider(
          create: (context) => HabitDatabase(),
        ),
        //Theme Provider
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const HomePage(),
    );
  }
}
