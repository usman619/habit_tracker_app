import 'package:isar/isar.dart';
part 'habit.g.dart';
// run in terminal: `dart run build_runner build` to generate the above file

@Collection()
class Habit {
  Id id = Isar.autoIncrement;
  late String name;
  List<DateTime> completedDays = [];
}
