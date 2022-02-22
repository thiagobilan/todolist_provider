import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolist_provider/app/core/ui/theme_extension.dart';
import 'package:todolist_provider/app/modules/tasks/tasks_create_controller.dart';

class CalendarButton extends StatelessWidget {
  final dateformat = DateFormat('dd/MM/y');
  CalendarButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () async {
        var lastDate = DateTime.now();
        lastDate = lastDate.add(const Duration(days: 5 * 365));
        final DateTime? selectedDate = await showDatePicker(
          // useRootNavigator: false,
          // locale: Locale('pt', 'BR'),
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: lastDate,
        );
        context.read<TasksCreateController>().selectedDate = selectedDate;
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.today,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            Selector<TasksCreateController, DateTime?>(
              selector: (contex, controller) => controller.selectedDate,
              builder: (contex, selectedDate, child) {
                if (selectedDate != null) {
                  return Text(dateformat.format(selectedDate));
                } else {
                  return const Text('SELECIONE UMA DATA');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
