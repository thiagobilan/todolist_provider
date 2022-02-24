import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolist_provider/app/models/task_model.dart';
import 'package:todolist_provider/app/modules/home/home_controller.dart';

class Task extends StatelessWidget {
  final TaskModel model;
  final dateFormat = DateFormat('dd/MM/y');
  Task({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(model.id.toString()),
        direction: DismissDirection.endToStart,
        confirmDismiss: (_) => _buildConfirmDismiss(context),
        onDismissed: (_) async {
          await context.read<HomeController>().deleteTask(model);
        },
        background: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text(
                'Excluir',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
              Icon(Icons.delete, color: Colors.white),
              SizedBox(
                width: 20,
              )
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(color: Colors.grey),
            ],
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
              ),
            ],
          ),
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: IntrinsicHeight(
            child: ListTile(
              contentPadding: const EdgeInsets.all(8),
              leading: Checkbox(
                onChanged: (value) =>
                    context.read<HomeController>().chechOrUncheckTask(model),
                value: model.finished,
              ),
              title: Text(
                model.description,
                style: TextStyle(
                  decoration:
                      model.finished ? TextDecoration.lineThrough : null,
                  decorationColor: Colors.black,
                  decorationThickness: 10,
                ),
              ),
              subtitle: Text(
                dateFormat.format(model.dateTime),
                style: TextStyle(
                  decoration:
                      model.finished ? TextDecoration.lineThrough : null,
                  decorationColor: Colors.black,
                  decorationThickness: 10,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(width: 1)),
            ),
          ),
        ));
  }

  Future<bool> _buildConfirmDismiss(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Excluir!'),
          content: const Text('Confirma a exclusão da TASK?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Cancelar')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Confirmar'))
          ],
        );
      },
    );
  }
}
