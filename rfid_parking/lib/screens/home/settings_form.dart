import 'package:flutter/material.dart';
import 'package:rfid_parking/models/user_model.dart';
import 'package:rfid_parking/screens/home/profile_format.dart';
//import 'package:rfid_parking/screens/home/settings_form.dart';
import 'package:rfid_parking/services/auth.dart';
import 'package:rfid_parking/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rfid_parking/screens/home/user_list.dart';

class Profile extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    /*
    void _showSettingsPannel() {
      showModalBottomSheet(
        context: context, 
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: SettingsForm(),
          );
        },
        isScrollControlled: true,
      );
    }*/
    return StreamProvider<List<UserModel>>.value(
        value: DatabaseService().users,
        child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: Text('RFID Parking'),
          backgroundColor: Colors.purple[900],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person_outline),
              onPressed: () async{
                await _auth.signOut();
              }, 
              label: Text('Logout'),
            ),
            /*
            FlatButton.icon(
              onPressed: () {
                Navigator.pop(context);
              }, 
              icon: Icon(Icons.person), 
              label: Text('Home'),
            ),*/
          ],
        ),
        body: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            ProfileFormat()
          ],
        ),
      )
    );
  }
}