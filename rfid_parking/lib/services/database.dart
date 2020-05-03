import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rfid_parking/models/user.dart';
import 'package:rfid_parking/models/user_model.dart';

 class DatabaseService {

   final String uid;
   DatabaseService({this.uid});
   List<String> availableSlots = ['L1A1','L1A2','L1A3','L1B1','L1B2','L1B3','L2A1','L2A2','L2A3','L2B1','L2B2','L2B3','UG1A1','UG1A2','UG1A3','UG1B1','UG1B2','UG1B3','UG2A1','UG2A2','UG2A3','UG2B1','UG2B2','UG2B3'];

   //collection reference
   final CollectionReference userCollection = Firestore.instance.collection('users');

  Future updateUserData (String name, String vehicleNo, int pendingAmt, int startTime, bool parkStatus, int mobNumber, String currFloor, String currSlot, String currFloorSlot) async { 
    return await userCollection.document(uid).setData({
      'name': name,
      'vehicleNo': vehicleNo,
      'pendingAmt': pendingAmt,
      'startTime': startTime,
      'parkStatus': parkStatus,
      'mobNumber': mobNumber,
      'currFloor': currFloor,
      'currSlot': currSlot,
      'currFloorSlot': currFloorSlot,
    });
  }

  //user list from snapshot
  List<UserModel> _userListFromSnapshot(QuerySnapshot snapshot) {
    
    List<UserModel> x = snapshot.documents.map((doc) {
      return UserModel(
        name: doc.data['name'] ?? 'Example',
        vehicleNo: doc.data['vehicleNo'] ?? 'AA00AA0000',
        pendingAmt: doc.data['pendingAmt'] ?? 0,
        startTime: doc.data['startTime'] ?? 0,
        parkStatus: doc.data['parkStatus'] ?? false,
        mobNumber: doc.data['mobNumber'] ?? 9999999999,
        currFloor: doc.data['currFloor'] ?? '',
        currSlot: doc.data['currSlot'] ?? '',
        currFloorSlot: doc.data['currFloorSlot'] ?? '',
      );
    }).toList();
    x.removeWhere((user) => user.parkStatus==false);
    
    for(int i=0; i<x.length;i++) {
      this.availableSlots.removeWhere((val) => val==x[i].currFloorSlot && x[i].currFloorSlot!=null );
      //print(availableSlots);
    }
    return x;
  }
  
  bool getavailability(String floorSlotC) {
    if( availableSlots.contains(floorSlotC)) {
      print('Here');
      return true;
    } else {
      print(availableSlots);
      print('Not Here');
      return true;
    }
  }

  
  //user data from snapshots
  UserData _userDataFromSnapshot (DocumentSnapshot snapshot) {
    UserData x = UserData(
      uid: uid,
      name: snapshot.data['name'],
      vehicleNo: snapshot.data['vehicleNo'],
      pendingAmt: snapshot.data['pendingAmt'],
      startTime: snapshot.data['startTime'],
      parkStatus: snapshot.data['parkStatus'],
      mobNumber: snapshot.data['mobNumber'],
      currFloor: snapshot.data['currFloor'],
      currSlot: snapshot.data['currSlot'],
      currFloorSlot: snapshot.data['currFloorSlot'],
    );
    /*
    if(x.currFloorSlot!=null) {
      availableSlots.removeWhere((val) => val == x.currFloorSlot);
    }*/
    return x;
  }

  //get users stream
  Stream<List<UserModel>> get users {
    return userCollection.snapshots()
      .map(_userListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }

 }
/*
 class BookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('books').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
                  title: new Text(document['title']),
                  subtitle: new Text(document['author']),
                );
              }).toList(),
            );
        }
      },
    );
  }
}*/