import 'package:flutter/src/widgets/framework.dart';
import 'package:todolist_provider/app/core/modules/todo_list_module.dart';
import 'package:todolist_provider/app/modules/home/home_page.dart';

class HomeModule extends TodoListModule {
  HomeModule()
      : super(router: {
          '/home': (context) => const HomePage(),
        });
}
