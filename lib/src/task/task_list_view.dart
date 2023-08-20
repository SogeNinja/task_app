import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:task_app/src/db/testing.dart';
import 'package:task_app/src/task/create_task_view.dart';
import 'package:task_app/src/task/task.dart';
import 'package:task_app/src/task/task_view.dart';
import 'package:task_app/src/task/update_task_view.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({ super.key });
  static const routeName = "/";
  @override
  State<TaskListView> createState() => _TaskListViewState();
}
class _TaskListViewState extends State<TaskListView> {
  List<Task> tasks = [];
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async{
      await updateListFromDataBase();
    });
    super.initState();
  }

  Future<void> updateListFromDataBase() async{
    tasks = await getTasksList();
    setState((){});
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: CupertinoPageScaffold(
        child: SafeArea(child: CustomScrollView(
          slivers:  <Widget>[
            CupertinoSliverNavigationBar(
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(Icons.add,size: 40),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CreateTaskView.routeName).then((value) async => await updateListFromDataBase());
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
                      placeholder: "Buscar",
                      prefix: const Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.search)),
                        onTapOutside: (event) {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                    )
                  ),
                  tasks.isNotEmpty
                  ? CupertinoListSection(
                    children: getTasksListWidget(context),
                  )
                  : const Text("Ingrese una tarea para continuar")
                ]
              )
            )
          ]
        )
      ))
    );
  }

  List<CupertinoContextMenu> getTasksListWidget(BuildContext context){
    List<CupertinoContextMenu> list = [];

    for(var task in tasks){
      list.add(
        CupertinoContextMenu(
          actions: [
            CupertinoContextMenuAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                trailingIcon: Icons.content_copy_outlined,
                child: const Text('Copiar',),
              ),
              CupertinoContextMenuAction(
                onPressed: () async{
                  await Navigator.of(context).pushNamed(UpdateTaskView.routeName, arguments: task).then((value) async{
                    await updateListFromDataBase();
                    Navigator.of(context).pop();
                  });
                },
                trailingIcon: Icons.content_copy_outlined,
                child: const Text('Editar',),
              ),
              CupertinoContextMenuAction(
                isDestructiveAction: true,
                onPressed: () async{
                  await deleteTask(task.id);
                  await updateListFromDataBase();
                  Navigator.pop(context);
                },
                trailingIcon: Icons.delete,
                child: const Text('Borrar'),
              ),
          ],
          // ignore: deprecated_member_use
          previewBuilder: ((context, animation, child) {
            return Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(31, 35, 35, 35),
                borderRadius: BorderRadius.circular(20), // Ajusta el valor para controlar el radio de los bordes
              ),
              child: SingleChildScrollView(
                child: Column(
                children: [
                  Text(task.name, textAlign: TextAlign.start,style: const TextStyle(fontSize: 30),),
                  Text(task.description, textAlign: TextAlign.start,style: const TextStyle())
              ]),
              )
            );
          }),
          child: CupertinoListTile(
            title: Text(task.name),
            onTap: () {
              Navigator.pushNamed(
                context,
                TaskView.routeName,
                arguments: task
              ).then((value) async => await updateListFromDataBase());
            }
          )
          
        )
      );
    }
    return list;
  }
}
