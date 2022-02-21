import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolist_provider/app/core/navigator/todo_list_navigator.dart';
import 'package:todolist_provider/app/core/ui/todo_list_ui_config.dart';
import 'package:todolist_provider/app/modules/auth_module.dart';
import 'package:todolist_provider/app/modules/home/home_module.dart';
import 'package:todolist_provider/app/modules/splash/splash_page.dart';
import 'package:todolist_provider/app/core/database/sqlite_adm_connection.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final sqliteAdmConnection = SqliteAdmConnection();
  @override
  void initState() {
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;

    WidgetsBinding.instance?.addObserver(sqliteAdmConnection);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(sqliteAdmConnection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List com Provider',
      theme: TodoListUiConfig.theme,
      navigatorKey: TodoListNavigator.navigatorKey,
      debugShowCheckedModeBanner: false,
      routes: {
        ...AuthModule().routers,
        ...HomeModule().routers,
      },
      home: const SplashPage(),
    );
  }
}
