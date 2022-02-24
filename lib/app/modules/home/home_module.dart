import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:todolist_provider/app/core/modules/todo_list_module.dart';
import 'package:todolist_provider/app/modules/home/home_controller.dart';
import 'package:todolist_provider/app/modules/home/home_page.dart';
import 'package:todolist_provider/app/repositories/user/tasks/tasks_repository.dart';
import 'package:todolist_provider/app/repositories/user/tasks/tasks_repository_impl.dart';
import 'package:todolist_provider/app/services/tasks/tasks_service.dart';
import 'package:todolist_provider/app/services/tasks/tasks_service_impl.dart';

class HomeModule extends TodoListModule {
  HomeModule()
      : super(bindinds: [
          Provider<TasksRepository>(
            create: (context) => TasksRepositoryImpl(
              sqliteConnectionFactory: context.read(),
            ),
          ),
          Provider<TasksService>(
            create: (context) => TasksServiceImpl(
              tasksRepository: context.read(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => HomeController(tasksService: context.read()),
          )
        ], router: {
          '/home': (context) => HomePage(homeController: context.read()),
        });
}
