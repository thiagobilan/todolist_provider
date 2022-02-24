import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_provider/app/core/ui/theme_extension.dart';
import 'package:todolist_provider/app/models/task_enum.dart';
import 'package:todolist_provider/app/models/total_task_model.dart';
import 'package:todolist_provider/app/modules/home/home_controller.dart';

class TodoCardFilter extends StatelessWidget {
  final String label;
  final TaskFilterEnum taskFilter;
  final TotalTaskModel? totalTaskModel;
  final bool selected;

  const TodoCardFilter({
    Key? key,
    required this.label,
    required this.selected,
    required this.taskFilter,
    this.totalTaskModel,
  }) : super(key: key);

  _getPercentFinish() {
    final total = totalTaskModel?.totalTasks ?? 0;
    final totalFinish = totalTaskModel?.totalTasksFinish ?? 0.1;
    if (total == 0) {
      return 0.0;
    }
    final percent = (totalFinish * 100) / total;
    return percent / 100;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () => context.read<HomeController>().findTasks(filter: taskFilter),
      child: Container(
        constraints: const BoxConstraints(minHeight: 120, maxWidth: 150),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: selected ? context.primaryColor : Colors.white,
          border: Border.all(
            width: 1,
            color: Colors.grey.withOpacity(.8),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${totalTaskModel?.taskNotFinished ?? '0'} TASKS',
              style: selected
                  ? context.titleStyle
                      .copyWith(fontSize: 13, color: Colors.white)
                  : context.titleStyle
                      .copyWith(fontSize: 13, color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                label,
                style: selected
                    ? const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)
                    : const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
              ),
            ),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: _getPercentFinish()),
              duration: const Duration(seconds: 1),
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  backgroundColor: selected
                      ? context.primaryColorLight
                      : Colors.grey.shade300,
                  value: value,
                  valueColor: selected
                      ? AlwaysStoppedAnimation<Color>(Colors.white)
                      : AlwaysStoppedAnimation<Color>(context.primaryColor),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
