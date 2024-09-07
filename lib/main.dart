import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_crud/login/login.dart';
import 'package:flutter_firebase_crud/login/signIn.dart';
import 'package:flutter_firebase_crud/screen/HomeScreen.dart';

import 'package:flutter_firebase_crud/screen/student.dart';
import 'firebase_options.dart';
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      // home: MYHome(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return const MyHomeScreen();
          }
          else{
            return const MySignin();
          }
        },
      ),
    );
  }
}