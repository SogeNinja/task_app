/// A placeholder class that represents an entity or model.
class Task {
  final int id;
  String name;
  String description;
  int type;
  List<int> selectedDays;
  DateTime selectedHour;

  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.selectedDays,
    required this.selectedHour
  });

  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'name':name,
      'description':description,
      'type':type,
      'selectedDays':selectedDays.toString(),
      'selectedHour':selectedHour.toString(),
    };
  }

  @override
  String toString() {
    return 'Task{id: $id, name: $name, description: $description, type: $type, selectedDays: $selectedDays, selectedHour: $selectedHour}';
  }
}
