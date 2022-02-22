import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  const Task({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.grey)],
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: IntrinsicHeight(
        child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          leading: Checkbox(
            onChanged: (value) {},
            value: true,
          ),
          title: Text(
            'Descrição da Task',
            style: TextStyle(
              decoration: false ? TextDecoration.lineThrough : null,
              decorationColor: Colors.black,
              decorationThickness: 10,
            ),
          ),
          subtitle: Text(
            '21/02/2022',
            style: TextStyle(
              decoration: false ? TextDecoration.lineThrough : null,
              decorationColor: Colors.black,
              decorationThickness: 10,
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(width: 1)),
        ),
      ),
    );
  }
}
