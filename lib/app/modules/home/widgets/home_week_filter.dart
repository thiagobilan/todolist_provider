import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_provider/app/core/ui/theme_extension.dart';
import 'package:todolist_provider/app/models/task_enum.dart';
import 'package:todolist_provider/app/modules/home/home_controller.dart';

class HomeWeekFilter extends StatelessWidget {
  const HomeWeekFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.select<HomeController, bool>(
          (controller) => controller.filterSelected == TaskFilterEnum.week),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            'DIA DA SEMANA',
            style: context.titleStyle,
          ),
          const SizedBox(height: 10),
          Container(
            height: 95,
            child: Selector<HomeController, DateTime>(
              selector: (context, controller) =>
                  controller.initialDateOfWeek ?? DateTime.now(),
              builder: (context, value, child) => DatePicker(
                value,
                locale: 'pt_BR',
                initialSelectedDate: value,
                selectionColor: context.primaryColor,
                selectedTextColor: Colors.white,
                daysCount: 7,
                monthTextStyle: const TextStyle(fontSize: 10),
                dayTextStyle: const TextStyle(fontSize: 14),
                dateTextStyle: const TextStyle(fontSize: 18),
                onDateChange: (date) {
                  context.read<HomeController>().filterByDay(date);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
