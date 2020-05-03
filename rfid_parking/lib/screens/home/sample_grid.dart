import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rfid_parking/models/user_model.dart';
import 'package:rfid_parking/screens/home/sample_tile.dart';
import 'package:rfid_parking/screens/home/user_tile.dart';

class SampleGrid extends StatefulWidget {
  @override
  _SampleGridState createState() => _SampleGridState();
}

class _SampleGridState extends State<SampleGrid> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<UserModel>>(context) ?? [];
    //print(users.documents);
    return GridView.builder(
      itemCount: users.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount: 2),
      itemBuilder: (context, index) {
        //print(users[index].currFloor);
        //print(users[index].currSlot);
        return SampleTile(user: users[index]);
        
      },
    );
  }
}
/*
CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid.count(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
              )
            )
          ]
        )*/