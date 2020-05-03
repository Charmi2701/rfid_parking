import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rfid_parking/models/user.dart';
import 'package:rfid_parking/screens/home/profile_temp2.dart';
import 'package:rfid_parking/screens/home/sample_grid_view.dart';
import 'package:rfid_parking/screens/home/settings_form.dart';
import 'package:rfid_parking/screens/wrapper.dart';
import 'package:rfid_parking/services/auth.dart';
void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  )
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}