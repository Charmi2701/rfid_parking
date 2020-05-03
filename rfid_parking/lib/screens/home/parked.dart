import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rfid_parking/models/user.dart';
import 'package:rfid_parking/services/database.dart';

class Parked extends StatefulWidget {
  @override
  _ParkedState createState() => _ParkedState();
}

class _ParkedState extends State<Parked> {
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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          UserData userData = snapshot.data;
          //var timeEndTemp = new DateTime.now().millisecondsSinceEpoch;
          //Timer(Duration(milliseconds: 1), () => timeEndTemp = DateTime.now().millisecondsSinceEpoch);
          //var diffTemp = timeEndTemp-userData.startTime;
          var diffTemp2 = Duration(seconds: ((DateTime.now().millisecondsSinceEpoch-userData.startTime)/1000).round());
          return Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0,),
                  Text('Your Car is parked at',style: TextStyle(fontSize: 30),),
                  SizedBox(height: 100.0,),
                  Text('Floor' ,style: TextStyle(fontSize: 22,),),
                  SizedBox(height: 5.0,),
                  Text(userData.currFloor ,style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),),
                  SizedBox(height: 40.0,),
                  Text('Slot' ,style: TextStyle(fontSize: 22,),),
                  SizedBox(height: 5.0,),
                  Text(userData.currSlot ,style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),),
                  SizedBox(height: 50.0,),
                  RaisedButton(
                    color: Colors.purple[900],
                    child: Text(
                      'End Parking',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()) {
                        var timeEnd = new DateTime.now().millisecondsSinceEpoch;
                        var diff = timeEnd-userData.startTime;
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentName ?? userData.name, 
                          _currentVehicleNo ?? userData.vehicleNo, 
                          userData.pendingAmt + ((timeEnd-userData.startTime)*0.0000833).round(), 
                          0, 
                          false, 
                          _currentMobNumber ?? userData.mobNumber, 
                          null, 
                          null,
                          null
                        );
                        //Navigator.pop(context);
                      }
                    }
                  ),
                  SizedBox(height: 10.0),
                  Text('Time parked: ${_printDuration(Duration(milliseconds: (DateTime.now().millisecondsSinceEpoch-userData.startTime)))}'),
                ],
              )
            )
          );
        } else {
          return Container(child: Text('User Data Not Fount :(', style: TextStyle(fontSize: 18),),);
        }
      }
    );
  }
}

String _printDuration(Duration duration) {
  return "${duration.inHours.remainder(24)}:${duration.inMinutes.remainder(60)}:${duration.inSeconds.remainder(60)}";
}
