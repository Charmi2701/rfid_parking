import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rfid_parking/models/user.dart';
import 'package:rfid_parking/screens/authenticate/authenticate.dart';
import 'package:rfid_parking/screens/home/home_page.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    //return either home or authenticate
    if(user == null) {
      return Authenticate();
    } else {
      return HomePage();
    }
  }
}