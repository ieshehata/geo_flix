import 'package:flutter/material.dart';
import 'package:geo_flix/features/login/login_view.dart';

import '../../core/utils/functions.dart';
import '../../features/profile/profile_page.dart';


class Drawer extends StatelessWidget {
  const Drawer({Key? key, required SingleChildScrollView child}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  runSpacing: 16,
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      title: const Text("Allocated Location: "),
                      onTap: () {
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      title: const Text("Edit Your Profile"),
                      onTap: () {
                        navigateTo(context, const ProfilePage());
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.login_outlined,
                        color: Colors.white,
                      ),
                      title: const Text("Logout"),
                      onTap: () {
                        navigateTo(context,  LoginView());                      },
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      );
}
