import 'package:provider/provider.dart';
import 'package:todolist_provider/app/core/modules/todo_list_module.dart';
import 'package:todolist_provider/app/modules/login/login_controller.dart';
import 'package:todolist_provider/app/modules/login/login_page.dart';

class AuthModule extends TodoListModule {
  AuthModule()
      : super(bindinds: [
          ChangeNotifierProvider(
            create: (context) => LoginController(),
          )
        ], router: {
          '/login': (context) => const LoginPage(),
        });
}
