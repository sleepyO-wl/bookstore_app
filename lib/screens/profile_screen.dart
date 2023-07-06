import 'package:bookstore/provider/auth_service.dart';
import 'package:bookstore/provider/user_provider.dart';
import 'package:bookstore/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
              height: 100,
              width: 100,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ficon-library.com%2Fimages%2Ficon-user%2Ficon-user-15.jpg&f=1&nofb=1&ipt=88298aa1baea9045ab1c6ddbafaa29053786275e4a6897c0b4ff0d3c5d8e61a9&ipo=images"),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Name: ${Provider.of<UserProvider>(context).user.name as String}',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              'Email id: ${Provider.of<UserProvider>(context).user.email as String}',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 23,
            ),
            SizedBox(
              height: 400,
              child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(96, 157, 155, 155),
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: null,
                            icon: Icon(
                              Icons.account_circle_outlined,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                            label: Text(
                              'Profile',
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(96, 157, 155, 155),
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: null,
                            icon: Icon(
                              Icons.settings,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                            label: Text(
                              'Settings',
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(96, 157, 155, 155),
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: null,
                            icon: Icon(
                              Icons.settings_display,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                            label: Text(
                              'Theme',
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(96, 157, 155, 155),
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              // SharedPreferences sharedPreferences =
                              //     await SharedPreferences.getInstance();
                              // await sharedPreferences.setString('token', '');
                              // // ignore: use_build_context_synchronously
                              // Navigator.pushReplacementNamed(
                              //   context,
                              //   AuthenticationScreen.routeName,
                              // );
                            },
                            icon: Icon(
                              Icons.logout,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                            label: Text(
                              'Logout',
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
