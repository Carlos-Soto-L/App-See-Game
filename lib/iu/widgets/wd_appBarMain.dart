import 'package:app_see_game/class/SharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class AppBarMain extends StatelessWidget implements PreferredSizeWidget {
  final int? iControl;

  const AppBarMain({super.key, this.iControl});

// 2 - eventos api
// 3 - publicaciones en general

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  // https://pub.dev/packages/fluent_ui

  @override
  Widget build(BuildContext context) {
    return GFAppBar(
      searchBar: true,
      onSubmitted: (String value) {
        // 1- videojuegos api
        if (iControl == 1) {
          Navigator.of(context).pushNamed("rtrVideojuegos", arguments: value);
        }else if(iControl == 2){
          Navigator.of(context).pushNamed("rtrEventos", arguments: value);
        }
      },
      title: const Text("SEE GAME"),
      actions: <Widget>[
        GFIconButton(
          icon: const Icon(
            Icons.account_circle,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed('rtrPerfilUser');
          },
          type: GFButtonType.transparent,
        ),
        GFIconButton(
          icon: const Icon(
            Icons.login_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            SharedPreferencesClass.removeData('token');
            Navigator.of(context).pushNamed('rtrInicio');
          },
          type: GFButtonType.transparent,
        ),
      ],
    );
    // return AppBar(
    //   title: Text("SEE GAME"),
    //   actions: [
    //     const SizedBox(
    //       width: 30,
    //     ),
    //     IconButton(
    //         onPressed: () {
    //           Navigator.of(context).pushNamed('rtrPerfilUser');
    //         },
    //         icon: const Icon(Icons.account_circle)),
    //     IconButton(
    //         onPressed: () {
    //           SharedPreferencesClass.removeData('token');
    //           Navigator.of(context).pushNamed('rtrInicio');
    //         },
    //         icon: const Icon(Icons.login_outlined))
    //   ],
    // );
  }
}
