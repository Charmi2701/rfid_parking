class User {
  final String uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String vehicleNo;
  final int pendingAmt;
  final int startTime;
  final bool parkStatus;
  final int mobNumber;
  final String currFloor;
  final String currSlot;
  final String currFloorSlot;

  UserData({this.uid,this.name, this.vehicleNo, this.pendingAmt, this.startTime, this.parkStatus, this.mobNumber, this.currFloor, this.currSlot, this.currFloorSlot});

}