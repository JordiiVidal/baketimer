import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/routes.dart';

class HomePopupMenu extends StatelessWidget {
  const HomePopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      elevation: 5,
      position: PopupMenuPosition.under,
      itemBuilder: (context) => <PopupMenuEntry<PopupMenuItem>>[
        PopupMenuItem(
          child: logoutMenu(context),
        )
      ],
    );
  }

  GestureDetector logoutMenu(BuildContext context) {
    return GestureDetector(
          onTap: () => logoutDialog(context).then(
            (shouldLogout) {
              if (shouldLogout) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  loginRoute,
                  (route) => false,
                );
              }
            },
          ),
          child: Row(
            children: const [
              Icon(
                Icons.exit_to_app_rounded,
                color: Colors.black87,
              ),
              SizedBox(
                width: 25,
              ),
              Text('Log out'),
            ],
          ),
        );
  }

  Future<bool> logoutDialog(BuildContext context) async {
    return showModalBottomSheet<bool>(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Are you sure you want to log out?'),
              const SizedBox(
                height: 26.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Log out'),
                  )
                ],
              )
            ],
          ),
        );
      },
    ).then(
      (value) async {
        if (value == true) await FirebaseAuth.instance.signOut();
        return value ?? false;
      },
    );
    //await FirebaseAuth.instance.signOut();
  }
}
