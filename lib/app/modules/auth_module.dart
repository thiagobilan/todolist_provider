import 'package:provider/provider.dart';
import 'package:todolist_provider/app/core/modules/todo_list_module.dart';
import 'package:todolist_provider/app/modules/auth/login/login_controller.dart';
import 'package:todolist_provider/app/modules/auth/login/login_page.dart';
import 'package:todolist_provider/app/modules/auth/register/register_controller.dart';
import 'package:todolist_provider/app/modules/auth/register/register_page.dart';

class AuthModule extends TodoListModule {
  AuthModule()
      : super(bindinds: [
          ChangeNotifierProvider(
            create: (context) => LoginController(),
          ),
          ChangeNotifierProvider(
            create: (context) => RegisterController(),
          ),
        ], router: {
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
        });
}
