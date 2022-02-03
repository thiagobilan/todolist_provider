import 'package:flutter/material.dart';
import 'package:todolist_provider/app/core/ui/todo_list_ui_config.dart';
import 'package:todolist_provider/app/models/auth/auth_module.dart';
import 'package:todolist_provider/app/modules/splash/splash_page.dart';
import 'package:todolist_provider/app/sqlite_adm_connection.dart';

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
      theme: TodoListUiConfig.theme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        ...AuthModule().routers,
      },
      home: SplashPage(),
    );
  }
}
