import 'package:flutter/material.dart';
import 'package:rfid_parking/animations/fade_animation.dart';
import 'package:rfid_parking/services/auth.dart';
import 'package:rfid_parking/shared/constants.dart';
import 'package:rfid_parking/shared/loading.dart';
class Register extends StatefulWidget {

  
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field 
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        //padding: EdgeInsets.symmetric(vertical: 30),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.purple[900],
              Colors.blue[800],
              Colors.lightBlue[400],
            ]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(1, Text('Sign Up', style: TextStyle(color: Colors.white, fontSize: 40),)),
                  SizedBox(height: 10,),
                  FadeAnimation(1.3, Text('Welcome to RFID Parking', style: TextStyle(color: Colors.white, fontSize: 18),))
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60)),

                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height:60),
                      FadeAnimation(1.6, Container(
                        //padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [BoxShadow(
                            color: Color.fromRGBO(20, 0, 100, 3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          )]
                        ),
                        child: Form(
                          key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[200]),),
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Enter Email',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                                    onChanged: (val) {
                                      setState(() => email = val);
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[200]),),
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                    validator: (val) => val.length <6 ? 'Enter a password 6+ characters long' : null,
                                    obscureText: true,
                                    onChanged: (val) {
                                      setState(() => password = val);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      //Text('Forgot Password?', style: TextStyle(color: Colors.indigo),),
                      SizedBox(height: 40),
                      FadeAnimation(1.9, Column( 
                        children: <Widget>[
                          Container(
                            height: 50,
                            width: 225,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.deepPurple[900],
                            ),
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(color: Colors.blue[700]),
                                ),
                                color: Colors.deepPurple[900],
                                onPressed: () async {
                                  if(_formKey.currentState.validate()) {
                                    setState(() => loading = true);
                                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                                    if(result == null) {
                                      setState(() {
                                        error = 'Please provide valid credentials';
                                        loading = false;
                                      });
                                    }
                                  }
                                },
                                child: Text(
                                  'Register',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                          ),
                        ]
                      ),),
                      SizedBox(height: 60,),
                      FadeAnimation(2.2, Text('Already a Member?', style: TextStyle(color: Colors.grey[700], fontSize: 18),),),
                      SizedBox(height: 20,),
                      FadeAnimation(2.5, Container(
                            height: 50,
                            width: 400,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.deepPurple[900],
                            ),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Colors.blue[700]),
                              ),
                              color: Colors.deepPurple[900],
                              onPressed: () {
                                widget.toggleView();
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                      )),
                    ],
                  ),
                )
              )
            )
          ]
        ),
      )
    );
  }
}