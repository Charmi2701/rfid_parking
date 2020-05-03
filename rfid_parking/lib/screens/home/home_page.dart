import 'package:flutter/material.dart';
import 'package:rfid_parking/models/user_model.dart';
import 'package:rfid_parking/screens/home/home.dart';
import 'package:rfid_parking/screens/home/park.dart';
import 'package:rfid_parking/screens/home/profile_temp2.dart';
import 'package:rfid_parking/screens/home/sample_grid_view.dart';
import 'package:rfid_parking/screens/home/settings_form.dart';
import 'package:rfid_parking/services/auth.dart';
import 'package:rfid_parking/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rfid_parking/screens/home/user_list.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  
  TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: new Material(
        color: Colors.purple[900],
        child: TabBar(
          controller: tabController,
          tabs: <Widget>[
            new Tab(icon: Icon(Icons.home)),
            new Tab(icon: Icon(Icons.local_parking)),
            new Tab(icon: Icon(Icons.person)),
          ]
        ),
      ),
      body: new TabBarView(
        controller: tabController,
        children: <Widget>[
          Sample(),
          Park(),
          ProfileTemp2(),
        ]
      ),
    );
  }
}




