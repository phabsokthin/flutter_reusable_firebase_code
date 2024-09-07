import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/login/login.dart';
import 'package:flutter_firebase_crud/login/signIn.dart';
import 'package:flutter_firebase_crud/service/getUser.dart';
import 'package:flutter_firebase_crud/service/signOut.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {

  final GetUserService _userService = GetUserService();
  final SignoutService _signoutService = SignoutService();





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home screen"),
      ),
      body: Column(
        children: [

          Text("User ID is ${_userService.displayName()}"),

          Text("User ID is ${_userService.getUserId()}"),
          // Text("User ID is ${_userService.getCurrentUser()}"),
          Text("User Email is ${_userService.getUserEmail()}"),

          ElevatedButton(onPressed: (){
            _signoutService.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MySignin()));
          }, child: Text("Sign out")),
        ],
      ),
    );
  }
}
