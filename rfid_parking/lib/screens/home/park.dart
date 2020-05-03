import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rfid_parking/models/user.dart';
import 'package:rfid_parking/screens/home/not_parked.dart';
import 'package:rfid_parking/screens/home/parked.dart';
import 'package:rfid_parking/services/database.dart';

class Park extends StatefulWidget {
  @override
  _ParkState createState() => _ParkState();
}

class _ParkState extends State<Park> {
  final _formKey = GlobalKey<FormState>();
  final List<String> floors = ['L1', 'L2', 'UG1', 'UG2'];
  final List<String> slots = ['A1', 'A2', 'A3', 'B1', 'B2', 'B3'];

  String _currentName;
  String _currentVehicleNo;
  int _currentPendingAmt;
  int _currentStartTime;
  bool _currentParkStatus;
  int _currentMobNumber;
  String _currentCurrFloor;
  String _currentCurrSlot;
  String _currentCurrFloorSlot;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          UserData userData = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text('Park Your Vehicle'),
              backgroundColor: Colors.purple[900],
            ),
            body: userData.parkStatus ? Parked() : NotParked(),
          );
        } else {
          return Container(child: Text('User Data Not Fount :(', style: TextStyle(fontSize: 18),),);
        }
      }
    );
  }
}


