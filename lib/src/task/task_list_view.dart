import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_app/src/task/create_task_view.dart';
import 'package:task_app/src/task/task.dart';
import 'package:task_app/src/task/task_view.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({ super.key });
  static const routeName = "/";
  @override
  State<TaskListView> createState() => _TaskListViewState();
}
class _TaskListViewState extends State<TaskListView> {
  final List<Task> tasks = const [Task(1,"Tarea1","descripcion"), Task(2,"Tarea2","descripcion"), Task(3,"Tarea3","descripcion")];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: CupertinoPageScaffold(
        child: CustomScrollView(
          slivers:  <Widget>[
            CupertinoSliverNavigationBar(
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(Icons.add,size: 40),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CreateTaskView.routeName);
                  },
              ),
              largeTitle: const Text('Tareas de buebo'),
            ),
            SliverFillRemaining(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CupertinoTextField(
                      prefix: const Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.search)),
                        onTapOutside: (event) {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                    )
                  ),
                  CupertinoListSection(
                    children: getTasksListWidget(context),
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }

  List<CupertinoListTile> getTasksListWidget(BuildContext context){
    List<CupertinoListTile> list = [];

    for(var task in tasks){
      list.add(
        CupertinoListTile(
          title: Text(task.taskName),
          leading: const Icon(Icons.task),
          onTap: () {
            Navigator.pushNamed(
              context,
              TaskView.routeName,
              arguments: task
            );
          }
        )
      );
    }
    return list;
  }
}
