import 'package:flutter/material.dart';
import 'package:social_app_ui/components/post_item.dart';
import 'package:social_app_ui/util/data.dart';
import 'package:social_app_ui/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:social_app_ui/services/database.dart';
import 'package:social_app_ui/screens/user_list.dart';
import 'package:social_app_ui/models/usermodel.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<User>>.value(
      value: DatabaseService().users,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Feeds"),
          centerTitle: true,
          elevation: 0.0,
          actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('logout'),
                onPressed: () async{
                  await _auth.signOut();
              },
          ),
        ],
      ),
      body:
//      UserList(),
        ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20),
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int index) {
            Map post = posts[index];
            return PostItem(
              img: post['img'],
              name: post['name'],
              dp: post['dp'],
              time: post['time'],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        onPressed: () {},
      ),
    ),
    );
  }
}
