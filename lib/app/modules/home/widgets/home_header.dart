import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_provider/app/core/auth/auth_provider.dart';
import 'package:todolist_provider/app/core/ui/theme_extension.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Selector<AuthProvider, String>(
        builder: (context, value, child) => Text(
          'E ai, $value!',
          style: context.textTheme.headline5
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        selector: (context, authProvider) =>
            authProvider.user?.displayName ??
            authProvider.user?.email ??
            'Não Encontrado',
      ),
    );
  }
}
