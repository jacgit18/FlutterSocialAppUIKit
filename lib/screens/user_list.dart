import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app_ui/models/usermodel.dart';
import 'package:social_app_ui/screens/user_tile.dart';


import 'package:social_app_ui/components/post_item.dart';
import 'package:social_app_ui/util/data.dart';
import 'package:social_app_ui/services/auth.dart';
import 'package:social_app_ui/services/database.dart';
import 'package:social_app_ui/screens/user_list.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    //    ListView.builder(
//      padding: EdgeInsets.symmetric(horizontal: 20),
//      itemCount: posts.length,
//      itemBuilder: (BuildContext context, int index) {
//        Map post = posts[index];
//        return PostItem(
//          img: post['img'],
//          name: post['name'],
//          dp: post['dp'],
//          time: post['time'],
//        );
//      },
//    );

    final users = Provider.of<List<User>>(context);

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return UserTile(user: users[index]);
      },
    );
  }
}
