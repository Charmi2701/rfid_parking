import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rfid_parking/models/user.dart';
import 'package:rfid_parking/services/database.dart';
import 'package:rfid_parking/shared/constants.dart';
class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {

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
            child: Scaffold(
              resizeToAvoidBottomPadding: false,
              appBar: AppBar(
                title: Text('Park Your Vehicle'),
                backgroundColor: Colors.purple[900],
              ),
              body: Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      Text('Update Name:', style: TextStyle(fontSize: 20)),
                      SizedBox(height: 10.0),
                      TextFormField(
                        initialValue: userData.name,
                        decoration: textInputDecoration.copyWith(hintText: 'Update Name'),
                        validator: (val) => val.isEmpty ? 'Please enter a Name' : null,
                        onChanged: (val) {
                          setState(() => _currentName = val);
                        },
                      ),
                      SizedBox(height: 30.0),
                      Text('Update Vehicle Number:', style: TextStyle(fontSize: 20)),
                      SizedBox(height: 10.0),
                      TextFormField(
                        initialValue: userData.vehicleNo,
                        decoration: textInputDecoration.copyWith(hintText: 'Update Vehicle Number'),
                        validator: (val) => val.isEmpty ? 'Please enter a Vehicle Number' : null,
                        onChanged: (val) {
                          setState(() => _currentVehicleNo = val);
                        },
                      ),
                      SizedBox(height: 30.0),
                      Text('Update Mobile Number:', style: TextStyle(fontSize: 20)),
                      SizedBox(height: 10.0),
                      TextFormField(
                        initialValue: userData.mobNumber.toString(),
                        decoration: textInputDecoration.copyWith(hintText: 'Update Mobile Number'),
                        validator: (val) => val.isEmpty ? 'Please enter a Mobile Number' : null,
                        onChanged: (val) {
                          setState(() => _currentMobNumber = int.parse(val));
                        },
                      ),
                      SizedBox(height: 60),
                      Center(
                        child: Container(
                          width: 200,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: BorderSide(color: Colors.blue[700]),
                            ),
                            color: Colors.purple[900],
                            child: Text(
                              'Update',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async{
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
                            }
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container(child: Text('User Data Not Fount :(', style: TextStyle(fontSize: 18),),);
        }
      }
    );
  }
}