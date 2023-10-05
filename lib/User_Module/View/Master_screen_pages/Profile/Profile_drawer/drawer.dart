import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_scout/User_Module/components/my_list_title.dart';

class ProfileDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOut;
  const ProfileDrawer(
      {super.key, required this.onProfileTap, required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.green[100],
      child: Column(children: [
        DrawerHeader(
            child: Icon(
          Icons.person,
          color: Colors.white,
          size: 64,
        )),
        MyListTitle(
          icon: Icons.home,
          text: 'H O M E',
          onTap: () => Navigator.pop(context),
        ),
        MyListTitle(
          icon: Icons.person,
          text: 'P R O F I L E',
          onTap: () => onProfileTap!(),
        ),
        MyListTitle(
          icon: Icons.logout,
          text: 'L O G O U T',
          onTap: () => onSignOut!(),
        ),
      ]),
    );
  }
}
