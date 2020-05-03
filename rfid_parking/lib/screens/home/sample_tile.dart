import 'package:flutter/material.dart';
import 'package:rfid_parking/models/user_model.dart';

class SampleTile extends StatelessWidget {

final UserModel user;
SampleTile({this.user});

  @override
  Widget build(BuildContext context) {
    return user.parkStatus ? Padding(
      padding: EdgeInsets.only(top:8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: GridTile(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Container(
                  child: Center(
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        /*
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                            fit: BoxFit.cover),
                        */
                        borderRadius: BorderRadius.all(Radius.circular(75.0)),
                        boxShadow: [
                          BoxShadow(blurRadius: 7.0, color: Colors.black)
                        ]
                      )
                    ),
                  )
                ),
                /*
                SizedBox(height:15),
                Text(user.name, style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height:20),
                Text('Parked on floor ${user.currFloor} at Slot ${user.currSlot}', style: TextStyle(fontSize:17,), textAlign: TextAlign.center,),
                */
                SizedBox(height:25),
                Text(user.currFloor, style:TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                SizedBox(height:20),
                Text(user.currSlot, style:TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      )
    ) : Container();
  }
}