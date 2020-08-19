import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future<void> updateUserData(String username, String name, int age) async {
    return await userCollection.document(uid).setData({
      'username': username,
      'name': name,
      'age': age,
    });
  }

}

