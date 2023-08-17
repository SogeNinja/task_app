import 'package:flutter/cupertino.dart';
import 'package:task_app/src/task/task.dart';

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({ super.key });
  static const routeName = "/create_task";
  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  late Task taskData;

  @override
  Widget build(BuildContext context) {
    taskData = ModalRoute.of(context)!.settings.arguments as Task;
    return const CupertinoPageScaffold(
      child: Center(child: Text("asd")),
    );
  }
}