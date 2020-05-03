import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rfid_parking/models/user.dart';
import 'package:rfid_parking/models/user_model.dart';
import 'package:rfid_parking/screens/home/update_profile.dart';
import 'package:rfid_parking/services/database.dart';


class ProfileTemp2 extends StatefulWidget {
  @override
  _ProfileTemp2State createState() => _ProfileTemp2State();
}

class _ProfileTemp2State extends State<ProfileTemp2> {

  final _formKey = GlobalKey<FormState>();

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
            body: Form(
              key: _formKey,
              child: new Stack(
                children: <Widget>[
                  ClipPath(
                    child: Container(
                      decoration:BoxDecoration(
                        gradient:LinearGradient(
                          begin: Alignment.topCenter,
                          colors: [
                            Colors.purple[900],
                            Colors.blue[800],
                            Colors.lightBlue[400],
                          ]
                        )
                      ), 
                      //color: Colors.black.withOpacity(0.8)
                    ),
                    clipper: getClipper(),
                  ),
                  Positioned(
                      width: 420.0,
                      top: MediaQuery.of(context).size.height / 6,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 150.0,
                            height: 150.0,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.all(Radius.circular(75.0)),
                              boxShadow: [
                                BoxShadow(blurRadius: 7.0, color: Colors.black)
                              ]
                            )
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            '${userData.name}',
                            style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                          ),
                          SizedBox(height: 50.0),
                          Container(
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 10.0),
                                Text('Vehicle Number:' ,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                                SizedBox(width: 7.0),
                                Text('${userData.vehicleNo}' ,style: TextStyle(fontSize: 22,),),
                              ]
                            )
                          ),
                          SizedBox(height:15.0),
                          Container(
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 10.0),
                                Text('Mobile Number:' ,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                                SizedBox(width: 7.0),
                                Text('${userData.mobNumber}' ,style: TextStyle(fontSize: 22,),),
                              ]
                            )
                          ),
                          SizedBox(height:20.0),
                          Container(
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 10.0),
                                Text('Pending Amount:' ,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                                SizedBox(width: 7.0),
                                Text('${userData.pendingAmt} Rupees' ,style: TextStyle(fontSize: 22,),),
                              ]
                            )
                          ),
                          SizedBox(height: 10,),
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
                                  'Pay Now',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  if(_formKey.currentState.validate()) {
                                    await DatabaseService(uid: user.uid).updateUserData(
                                      _currentName ?? userData.name, 
                                      _currentVehicleNo ?? userData.vehicleNo, 
                                      0, 
                                      _currentStartTime ?? userData.startTime, 
                                      _currentParkStatus ?? userData.parkStatus, 
                                      _currentMobNumber ?? userData.mobNumber, 
                                      _currentCurrFloor ?? userData.currFloor, 
                                      _currentCurrSlot ?? userData.currSlot,
                                      _currentCurrFloorSlot ?? userData.currFloorSlot
                                    );
                                  }
                                }
                              ),
                            ),
                          ),
                          SizedBox(height: 60,),
                          Center(
                            child: Container(
                              width: 250,
                              child: RaisedButton(
                                /*
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(color: Colors.blue[700]),
                                ),*/
                                color: Colors.purple[900],
                                child: Text(
                                  'Update User Data',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfile()),);
                                }
                              ),
                            ),
                          ),
                        ],
                      )
                    ),
                  ],
                ),
            )
          );
        } else {
          return Container(child: Text('User Data Not Fount :(', style: TextStyle(fontSize: 18),),);
        }
      }
    );
  }
}


class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 3);
    path.lineTo(size.width + 450, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}