import 'package:rfid_parking/models/user.dart';
import 'package:rfid_parking/services/database.dart';
import 'package:rfid_parking/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rfid_parking/shared/loading.dart';

class ProfileFormat extends StatefulWidget {
  @override
  _ProfileFormatState createState() => _ProfileFormatState();
}

class _ProfileFormatState extends State<ProfileFormat> {

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
          return Form(
          key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Welcome ${userData.name}',
                  style: TextStyle(fontSize: 25.0, ),
                ),
                SizedBox(height: 5.0,),
                Row(
                  children: [
                    Text(
                      'Name: ${userData.name}',
                      style: TextStyle(fontSize: 18.0, ),
                    ),
                    SizedBox(width: 2.0),
                  ]
                ),
                SizedBox(height: 5.0),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration.copyWith(hintText: 'Update Name'),
                  validator: (val) => val.isEmpty ? 'Please enter a Name' : null,
                  onChanged: (val) {
                    setState(() => _currentName = val);
                  },
                ),
                
                Row(
                  children: [
                    Text(
                      'Vehicle Number:${userData.vehicleNo}',
                      style: TextStyle(fontSize: 18.0, ),
                    ),
                    SizedBox(width: 2.0),
                  ]
                ),
                SizedBox(height: 5.0),
                TextFormField(
                  initialValue: userData.vehicleNo,
                  decoration: textInputDecoration.copyWith(hintText: 'Update Vehicle No.'),
                  validator: (val) => val.isEmpty ? 'Please enter the Vehicle Number' : null,
                  onChanged: (val) {
                     setState(() => _currentVehicleNo = val);
                  },
                ),
                
                Row(
                  children: [
                    Text(
                      'Mobile Number:${userData.mobNumber}',
                      style: TextStyle(fontSize: 18.0, ),
                    ),
                    SizedBox(width: 2.0),
                  ]
                ),
                SizedBox(height: 5.0),
                TextFormField(
                  initialValue: userData.mobNumber.toString(),
                  decoration: textInputDecoration.copyWith(hintText: 'Update Mobile No.'),
                  validator: (val) => val.isEmpty ? 'Please enter the Mobile Number' : null,
                  onChanged: (val) {
                    setState(() => _currentMobNumber = int.parse(val));
                  },
                ),
                
                Row(
                  children: [
                    Text(
                      'Pending Amount:${userData.pendingAmt}',
                      style: TextStyle(fontSize: 18.0, ),
                    ),
                    SizedBox(width: 2.0),
                  ]
                ),
                SizedBox(height: 5.0),
                Row(
                  children: [
                    SizedBox(width: 250.0,),
                    RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Pay',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        setState(() => _currentPendingAmt = 0);
                        await DatabaseService(uid: user.uid).updateUserData(
                        userData.name, 
                        userData.vehicleNo, 
                        0, 
                        userData.startTime, 
                        userData.parkStatus, 
                        userData.mobNumber, 
                        userData.currFloor, 
                        userData.currSlot,
                        userData.currFloorSlot
                      );
                    }),
                  ]
                ),
                Row(
                  children: [
                    Text(
                      'Select Floor:',
                      style: TextStyle(fontSize: 18.0, ),
                    ),
                    SizedBox(width: 2.0),
                  ]
                ),
                SizedBox(height: 5.0),
                DropdownButtonFormField(
                  value: _currentCurrFloor ?? userData.currFloor,
                  decoration: textInputDecoration.copyWith(hintText: 'Floor'),
                  items: floors.map((floor) {
                    return DropdownMenuItem(
                      value: floor,
                      child: Text('Floor $floor '),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentCurrFloor = val ),
                ),
                Row(
                  children: [
                    Text(
                      'Select Slot:',
                      style: TextStyle(fontSize: 18.0, ),
                    ),
                    SizedBox(width: 2.0),
                  ]
                ),
                SizedBox(height: 5.0),
                DropdownButtonFormField(
                  value: _currentCurrSlot ?? userData.currSlot,
                  decoration: textInputDecoration.copyWith(hintText: 'Slot'),
                  items: slots.map((slot) {
                    return DropdownMenuItem(
                      value: slot,
                      child: Text('Slot $slot '),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentCurrSlot = val ),
                ),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentName ?? userData.name, 
                        _currentVehicleNo ?? userData.vehicleNo, 
                        _currentPendingAmt ?? userData.pendingAmt, 
                        _currentStartTime ?? userData.startTime, 
                        _currentParkStatus ?? userData.parkStatus, 
                        _currentMobNumber ?? userData.mobNumber, 
                        _currentCurrFloor ?? userData.currFloor, 
                        _currentCurrSlot ?? userData.currSlot,
                        _currentCurrFloorSlot ?? userData.currFloorSlot
                      );
                      Navigator.pop(context);
                    }
                }),
              ]
            )
          );
        } else {
          return Loading();
        }
        
      }
    );
  }
}