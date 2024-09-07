import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/composable/useCollection.dart';
import 'package:flutter_firebase_crud/service/signupService.dart';


class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Login"),
      ),
      body: MyForm(),
    );
  }
}


class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final FirebaseAuthService _authService = FirebaseAuthService();


  //add docs

  final FirestoreService _firestoreService = FirestoreService();

  void _addDocs() async{
    await _firestoreService.addDocument("users", {
      'userName': _usernameController.text.toLowerCase(),
      'email': _usernameController.text,
      'password': _passwordController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(

        child: Column(
          children: [

            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Please enter username',
                labelText: 'UserName *',
              ),
            ),

            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                hintText: 'Please enter email',
                labelText: 'Email *',
              ),

            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                icon: Icon(Icons.password),
                hintText: 'Please enter password',
                labelText: 'Password',
              ),
            ),

            SizedBox(height: 20,),
            ElevatedButton(onPressed: () async {

              User? user = await _authService.signUpWithEmailPassword(
                _emailController.text,
                _passwordController.text,
                _usernameController.text,
              );
              if (user != null) {
                _addDocs();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("User ${user.email} signed up successfully!")),
                );

                print(user.email);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Signup failed")),
                );
              }

            }, child: Text("Sign up"))
          ],
        ),
      ),
    );
  }
}



