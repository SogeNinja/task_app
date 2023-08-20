import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task_app/src/task/create_task_view.dart';
import 'package:task_app/src/task/update_task_view.dart';

import 'task/task_view.dart';
import 'task/task_list_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
      ],
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,
      theme: const CupertinoThemeData(
        primaryColor: Color.fromRGBO(168, 12, 97, 1),
        primaryContrastingColor: Color.fromRGBO(79, 20, 52, 1)
      ),
      onGenerateRoute: (RouteSettings routeSettings) {
        return CupertinoPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case TaskListView.routeName:
                return const TaskListView();
              case TaskView.routeName:
                return const TaskView();
              case CreateTaskView.routeName:
                return const CreateTaskView();
              case UpdateTaskView.routeName:
                return const UpdateTaskView();
              default:
                return const TaskListView();
            }
          },
        );
      },
    );
  }
}
