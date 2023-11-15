import 'package:app_see_game/class/SharedPreferences.dart';
import 'package:flutter/material.dart';

class AppBarMain extends StatelessWidget implements PreferredSizeWidget {
  const AppBarMain({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("SEE GAME"),
      actions: [
        const SizedBox(
          width: 30,
        ),
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('rtrPerfilUser');
            },
            icon: const Icon(Icons.account_circle)),
        IconButton(
            onPressed: () {
              SharedPreferencesClass.removeData('token');
              Navigator.of(context).pushNamed('rtrInicio');
            },
            icon: const Icon(Icons.login_outlined))
      ],
    );
  }
}
