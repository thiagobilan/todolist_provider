import 'package:flutter/material.dart';
import 'package:todolist_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:todolist_provider/app/core/ui/theme_extension.dart';
import 'package:todolist_provider/app/core/widget/todo_list_field.dart';
import 'package:todolist_provider/app/modules/tasks/tasks_create_controller.dart';
import 'package:todolist_provider/app/modules/tasks/widgets/calendar_button.dart';
import 'package:validatorless/validatorless.dart';

class TasksCreatePage extends StatefulWidget {
  final TasksCreateController _controller;

  TasksCreatePage({Key? key, required TasksCreateController controller})
      : _controller = controller,
        super(key: key);

  @override
  State<TasksCreatePage> createState() => _TasksCreatePageState();
}

class _TasksCreatePageState extends State<TasksCreatePage> {
  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: widget._controller).listener(
        context: context,
        successCallBack: (notifier, listenerInstance) {
          listenerInstance.dispose();
          Navigator.pop(context);
        });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionEC.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  final _descriptionEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.close, color: Colors.black),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: context.primaryColor,
          onPressed: () {
            final formValid = _formKey.currentState?.validate() ?? false;
            if (formValid) {
              widget._controller.save(_descriptionEC.text);
            }
          },
          label: const Text(
            'Salvar Task',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Criar Task',
                    style: context.titleStyle.copyWith(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TodoListField(
                  label: '',
                  controller: _descriptionEC,
                  validator: Validatorless.required('Descrição Obrigatória.'),
                ),
                const SizedBox(
                  height: 20,
                ),
                CalendarButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
