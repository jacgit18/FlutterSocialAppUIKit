import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app_ui/models/usermodel.dart';

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

  // brew list from snapshot
  List<User> _useListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return User(
          name: doc.data['name'] ?? '',
          age: doc.data['age'] ?? 0,
          username: doc.data['username'] ?? '0'
      );
    }).toList();
  }

// get users stream
  Stream<List<User>> get users {
    return userCollection.snapshots()
    .map(_useListFromSnapshot);
  }
}

