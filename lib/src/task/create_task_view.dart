import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_app/src/db/testing.dart';
import 'package:task_app/src/task/task.dart';

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({ super.key });
  static const routeName = "/create_task";
  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  final TextEditingController _taskNameController = TextEditingController(); 
  final TextEditingController _taskDescriptionController = TextEditingController();
  DateTime selectedHour = DateTime.now();

  @override
  Widget build(BuildContext context) {
    
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(

        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.of(context).pop();
            },
        ),
        middle: const Text("Añadir tarea"),
      ),
      child: SafeArea(
        child:  Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: 20,
              ),
              CupertinoTextField(
                controller: _taskNameController,
                placeholder: "Nombre",
              ),
              Container(height: 20),
              SizedBox(
                height: 100,
                child: CupertinoTextField(
                  maxLines: 10,
                  controller: _taskDescriptionController,
                  placeholder: "Descripción",
                )
              ),
              Container(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Hora de aviso"),
                  CupertinoButton(
                    onPressed: () => _showDialog(
                      CupertinoDatePicker(
                        initialDateTime: selectedHour,
                        mode: CupertinoDatePickerMode.time,
                        use24hFormat: true,
                        onDateTimeChanged: (DateTime newTime) {
                          setState(() => selectedHour = newTime);
                        },
                      ),
                    ),
                    child: Text(
                      '${selectedHour.hour}:${selectedHour.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ]
              ),
              Container(height: 20,),
              CupertinoButton.filled(
                child: const Text("Insertar",
                style: TextStyle(color: Colors.white),
                ), 
                onPressed: () async {
                  final Task task = Task(
                    id: DateTime.now().microsecondsSinceEpoch, 
                    name: _taskNameController.text, 
                    description: _taskDescriptionController.text, 
                    type: 0,
                    selectedDays: [],
                    selectedHour: selectedHour
                  );
                  Map<String,dynamic> response = await insertTask(task);
                  if(response["statusCode"] == 200){
                      Navigator.of(context).pop();
                  }else if(response["statusCode"] == 500){
                    _showDialogMessage(context, "Error", "No se puede añadir la tarea");
                  }else{
                  }
              }),
            ]
          )
        ),
      )
    );
  }

  Future<void> _showDialogMessage(BuildContext context, String title, String message) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }
}