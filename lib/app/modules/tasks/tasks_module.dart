import 'package:provider/provider.dart';
import 'package:todolist_provider/app/core/modules/todo_list_module.dart';
import 'package:todolist_provider/app/modules/tasks/tasks_create_controller.dart';
import 'package:todolist_provider/app/modules/tasks/tasks_create_page.dart';
import 'package:todolist_provider/app/repositories/user/tasks/tasks_repository.dart';
import 'package:todolist_provider/app/repositories/user/tasks/tasks_repository_impl.dart';
import 'package:todolist_provider/app/services/tasks/tasks_service.dart';
import 'package:todolist_provider/app/services/tasks/tasks_service_impl.dart';

class TasksModule extends TodoListModule {
  TasksModule()
      : super(
          bindinds: [
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
              create: (context) => TasksCreateController(
                tasksService: context.read(),
              ),
            )
          ],
          router: {
            '/task/create': (context) => TasksCreatePage(
                  controller: context.read(),
                )
          },
        );
}
