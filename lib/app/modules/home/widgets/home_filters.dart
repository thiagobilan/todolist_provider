import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_provider/app/core/ui/theme_extension.dart';
import 'package:todolist_provider/app/models/task_enum.dart';
import 'package:todolist_provider/app/models/total_task_model.dart';
import 'package:todolist_provider/app/modules/home/home_controller.dart';
import 'package:todolist_provider/app/modules/home/widgets/todo_card_filter.dart';

class HomeFilters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FILTROS',
          style: context.titleStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TodoCardFilter(
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.filterSelected) ==
                    TaskFilterEnum.today,
                label: 'HOJE',
                taskFilter: TaskFilterEnum.today,
                totalTaskModel: context.select<HomeController, TotalTaskModel?>(
                    (controller) => controller.todayTotalTask),
              ),
              TodoCardFilter(
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.filterSelected) ==
                    TaskFilterEnum.tomorrow,
                label: 'AMANHÃ',
                taskFilter: TaskFilterEnum.tomorrow,
                totalTaskModel: context.select<HomeController, TotalTaskModel?>(
                    (controller) => controller.tomorrowTotalTasks),
              ),
              TodoCardFilter(
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.filterSelected) ==
                    TaskFilterEnum.week,
                label: 'SEMANA',
                taskFilter: TaskFilterEnum.week,
                totalTaskModel: context.select<HomeController, TotalTaskModel?>(
                    (controller) => controller.weekTotalTasks),
              ),
            ],
          ),
        )
      ],
    );
  }
}
