import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rfid_parking/models/user_model.dart';
import 'package:rfid_parking/screens/home/user_tile.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<UserModel>>(context) ?? [];
    //print(users.documents);
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        //print(users[index].currFloor);
        //print(users[index].currSlot);
        if(users[index].currFloor != '' && users[index].currSlot != '') {
          return UserTile(user: users[index]);
        } else {
          return Container(

          );
        }
        
      },
    );
  }
}