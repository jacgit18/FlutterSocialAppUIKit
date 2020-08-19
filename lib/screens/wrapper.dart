import 'package:social_app_ui/screens/auth/authenticate.dart';
import 'package:social_app_ui/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app_ui/models/user.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);
    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return Home();
    }

  }
}