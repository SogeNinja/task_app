import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_app/src/task/task.dart';

class TaskView extends StatefulWidget {
  const TaskView({ super.key });
  static const routeName = "/task";
  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  late Task taskData;

  @override
  Widget build(BuildContext context) {
    taskData = ModalRoute.of(context)!.settings.arguments as Task;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.of(context).pop();
            },
        ),
        middle: Text(taskData.name),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(Icons.more_horiz),
            onPressed: () {
              _showActionSheet(context);
            },
        ),
      ),
      child: SafeArea(
        child: CupertinoListSection(
          children: [CupertinoListTile(title: Text(taskData.description)),]
        )
      )
    );
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Title'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Editar'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Borrar'),
          ),
        ],
      ),
    );
  }
}



