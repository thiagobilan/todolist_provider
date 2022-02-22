import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_provider/app/modules/home/widgets/home_header.dart';
import 'package:todolist_provider/app/core/ui/theme_extension.dart';
import 'package:todolist_provider/app/core/ui/todo_list_icons.dart';
import 'package:todolist_provider/app/modules/home/widgets/home_drawer.dart';
import 'package:todolist_provider/app/modules/home/widgets/home_filters.dart';
import 'package:todolist_provider/app/modules/home/widgets/home_tasks.dart';
import 'package:todolist_provider/app/modules/home/widgets/home_week_filter.dart';
import 'package:todolist_provider/app/modules/tasks/tasks_module.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _goToCreateTask(BuildContext context) =>
      Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation =
              CurvedAnimation(parent: animation, curve: Curves.easeInQuad);
          return ScaleTransition(
            scale: animation,
            alignment: Alignment.bottomRight,
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return TasksModule().getPage('/task/create', context);
        },
      ));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: context.primaryColor),
          backgroundColor: const Color(0xFFFAFBFE),
          elevation: 0,
          actions: [
            PopupMenuButton(
              icon: const Icon(TodoListIcons.filter),
              itemBuilder: (_) => [
                const PopupMenuItem<bool>(
                    child: Text('Mostrar tarefas comcluidas')),
              ],
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _goToCreateTask(context),
          backgroundColor: context.primaryColor,
          child: const Icon(Icons.add),
        ),
        drawer: HomeDrawer(),
        backgroundColor: const Color(0xFFFAFBFE),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.maxWidth,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeHeader(),
                        HomeFilters(),
                        HomeWeekFilter(),
                        HomeTasks(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
