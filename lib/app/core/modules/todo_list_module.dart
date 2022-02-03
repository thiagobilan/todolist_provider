import 'package:flutter/cupertino.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todolist_provider/app/core/modules/todo_list_page.dart';

abstract class TodoListModule {
  final Map<String, WidgetBuilder> _router;
  final List<SingleChildWidget>? _bindinds;
  TodoListModule(
      {List<SingleChildWidget>? bindinds,
      required Map<String, WidgetBuilder> router})
      : _router = router,
        _bindinds = bindinds;

  Map<String, WidgetBuilder> get routers {
    return _router.map((key, pageBuilder) => MapEntry(
        key,
        (_) => TodoListPage(
              bindings: _bindinds,
              page: pageBuilder,
            )));
  }
}
