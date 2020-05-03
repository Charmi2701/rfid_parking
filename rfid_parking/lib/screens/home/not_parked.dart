import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rfid_parking/models/user.dart';
import 'package:rfid_parking/services/database.dart';
import 'package:rfid_parking/shared/constants.dart';
import 'package:rfid_parking/models/user_model.dart';

class NotParked extends StatefulWidget {
  @override
  _NotParkedState createState() => _NotParkedState();
}

class _NotParkedState extends State<NotParked> {
  final _formKey = GlobalKey<FormState>();
  final List<String> floors = ['L1', 'L2', 'UG1', 'UG2'];
  final List<String> slots = ['A1', 'A2', 'A3', 'B1', 'B2', 'B3'];
  //final CollectionReference userCollection = Firestore.instance.collection('users');
  String error="";
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
    DatabaseService test = DatabaseService(uid: user.uid);
    //final users = Provider.of<List<UserModel>>(context) ?? [];
    return StreamBuilder<UserData>(
      stream: test.userData,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: 20.0),
                Center(
                  child: Text('Select Your Parking Lot',style: TextStyle(fontSize: 30),), 
                ),
                SizedBox(height:40),
                Row(
                  children: [
                    SizedBox(width:10.0),
                    Text(
                      'Select Floor:',
                      style: TextStyle(fontSize: 22.0, ),
                    ),
                    SizedBox(width: 2.0),
                  ]
                ),
                SizedBox(height:20),
                DropdownButtonFormField(
                  validator: (val) => val.isEmpty ? 'Please choose a Floor' : null,
                  value: _currentCurrFloor,
                  decoration: textInputDecoration.copyWith(hintText: 'Floor'),
                  items: floors.map((floor) {
                    return DropdownMenuItem(
                      value: floor,
                      child: Text('Floor $floor '),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentCurrFloor = val ),
                ),
                SizedBox(height:30),
                Row(
                  children: [
                    SizedBox(width:10.0),
                    Text(
                      'Select Slot:',
                      style: TextStyle(fontSize: 22.0, ),
                    ),
                    SizedBox(width: 2.0),
                  ]
                ),
                SizedBox(height:20),
                DropdownButtonFormField(
                  validator: (val) => val.isEmpty ? 'Please choose a Slot' : null,
                  value: _currentCurrSlot,
                  decoration: textInputDecoration.copyWith(hintText: 'Slot'),
                  items: slots.map((slot) {
                    return DropdownMenuItem(
                      value: slot,
                      child: Text('Slot $slot '),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentCurrSlot = val ),
                ),
                SizedBox(height:100),
                RaisedButton(
                  color: Colors.purple[900],
                  child: Text(
                    'Park',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    _currentCurrFloorSlot=_currentCurrFloor + _currentCurrSlot;
                    if(_formKey.currentState.validate() && test.getavailability(_currentCurrSlot)) {
                      var time = new DateTime.now().millisecondsSinceEpoch;
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentName ?? userData.name, 
                        _currentVehicleNo ?? userData.vehicleNo, 
                        _currentPendingAmt ?? userData.pendingAmt, 
                        time, 
                        true, 
                        _currentMobNumber ?? userData.mobNumber, 
                        _currentCurrFloor ?? userData.currFloor, 
                        _currentCurrSlot ?? userData.currSlot,
                        _currentCurrFloorSlot ?? userData.currFloorSlot
                      );
                      //Navigator.pop(context);
                    }
                    else {
                      error = 'Not Validated';
                    }
                }),
                SizedBox(height:5.0),
                Text(error,style: TextStyle(color: Colors.red, fontSize: 12,),),
              ]
            )   
          );
        } else {
          return Container(child: Text('User Data Not Fount :(', style: TextStyle(fontSize: 18),),);
        }
      }
    );
  }
}


