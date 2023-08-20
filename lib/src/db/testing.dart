import 'package:sqflite/sqflite.dart';
import 'package:task_app/src/task/task.dart';

final database = openDatabase(
  "database.db",
  onCreate: (db, version) async {
    // Run the CREATE TABLE statement on the database.
    await db.execute(
      'CREATE TABLE IF NOT EXISTS task (id INTEGER PRIMARY KEY, name TEXT, description TEXT, type INTEGER, selectedDays TEXT, selectedHour TEXT)',
    );
  },
  // Set the version. This executes the onCreate function and provides a
  // path to perform database upgrades and downgrades.
  version: 1,
);

Future<Map<String,dynamic>> insertTask(Task task) async {
  try{
    final db = await database;
    await db.insert(
      'task', 
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );

    return {
      "statusCode": 200
    };
  }
  catch(e){
    return {
      "statusCode":500,
      "message": e
    };
  }
  
}

Future<List<Task>> getTasksList() async {
  final db = await database;

  final List<Map<String, dynamic>> maps = await db.query('task');

  return List.generate(maps.length, (i) {
    return Task(
      id: maps[i]['id'],
      name: maps[i]['name'],
      description: maps[i]['description'],
      type: maps[i]['type'],
      selectedDays: stringToList(maps[i]['selectedDays']),
      selectedHour: DateTime.parse(maps[i]['selectedHour'])
    );
  });
}

Future<Map<String,dynamic>> updateTask(Task task) async {
  try{
    final db = await database;
    await db.update(
      'task',
      {'name':task.name, 'description': task.description, 'selectedDays':task.selectedDays.toString(), 'selectedHour':task.selectedHour.toString()},
      where: 'id = ?',
      whereArgs: [task.id]
    );
    print(task.toMap());
    return {
      "statusCode": 200
    };
  }
  catch(e){
    return {
      "statusCode":500,
      "message": e
    };
  }
}

Future<Map<String,dynamic>> deleteTask(id) async {
  try{
    final db = await database;
    await db.delete(
      'task', 
      where: 'id = ?',
      whereArgs: [id]
    );
    return {
      "statusCode": 200
    };
  }
  catch(e){
    return {
      "statusCode":500,
      "message": e
    };
  }
}

List<int> stringToList(String str) {
  String cleanStr = str.replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '');

  if (cleanStr.isEmpty) {
    return [];
  }

  List<String> stringList = cleanStr.split(',');

  List<int> intList = stringList.map((e) => int.parse(e)).toList();

  return intList;
}
