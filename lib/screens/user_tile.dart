import 'package:flutter/material.dart';
import 'package:social_app_ui/models/usermodel.dart';

class UserTile extends StatelessWidget {

  final User user;
  UserTile({ this.user });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[user.age],
          ),
          title: Text(user.name),
          subtitle: Text('update ${user.username} info'),
        ),
      ),
    );
  }
}