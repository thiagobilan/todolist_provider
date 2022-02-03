import 'package:flutter/material.dart';
import 'package:todolist_provider/app/core/ui/theme_extension.dart';

class TodoListLogo extends StatelessWidget {
  const TodoListLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo.png',
          height: 200,
        ),
        Text('Todo List', style: context.textTheme.headline6)
      ],
    );
  }
}
