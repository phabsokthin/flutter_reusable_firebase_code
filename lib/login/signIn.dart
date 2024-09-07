import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/login/login.dart';
import 'package:flutter_firebase_crud/screen/HomeScreen.dart';
import 'package:flutter_firebase_crud/screen/viewUserTest.dart';
import 'package:flutter_firebase_crud/service/signinService.dart';

class MySignin extends StatefulWidget {
  const MySignin({super.key});

  @override
  State<MySignin> createState() => _MySigninState();
}

class _MySigninState extends State<MySignin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in"),
      ),
      body: const MySign(),
    );
  }
}

class MySign extends StatefulWidget {
  const MySign({super.key});

  @override
  State<MySign> createState() => _MySignState();
}

class _MySignState extends State<MySign> {
  final Signinservice _signinservice = Signinservice();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  void signIn() async {
    setState(() {
      _errorMessage = null; // Clear previous error message
    });
    try {
      // Call the sign-in method and handle the result
      String? result = await _signinservice.signInWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );

      if (result == null) {
        // Navigate to home screen if sign-in is successful
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomeScreen()),
        );
      } else {
        // Display error message if sign-in fails
        setState(() {
          _errorMessage = result;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "An error occurred. Please try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              icon: Icon(Icons.email),
              hintText: 'Please enter your email',
              labelText: 'Email *',
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _passwordController,
            obscureText: true, // Hide password input
            decoration: const InputDecoration(
              icon: Icon(Icons.lock),
              hintText: 'Please enter your password',
              labelText: 'Password *',
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: signIn,
            child: const Text("Login"),
          ),

          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyLogin()));

          }, child: Text("Sign up")),

          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyViewUser()));
          }, child: Text("View User")),
          if (_errorMessage != null) ...[
            const SizedBox(height: 16.0),
            Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),


          ],
        ],
      ),
    );
  }
}
