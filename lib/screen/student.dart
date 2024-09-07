import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/screen/student_list.dart';
import 'package:flutter_firebase_crud/service/database.dart';

class MyStudent extends StatefulWidget {
  const MyStudent({super.key});

  @override
  State<MyStudent> createState() => _MyStudentState();
}

class _MyStudentState extends State<MyStudent> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Student(),
    );
  }
}

class Student extends StatefulWidget {
  const Student({super.key});

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  TextEditingController studentName = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();

  void clearForm() {
    studentName.clear();
    email.clear();
    phone.clear();
  }

  //add student
  Future<void> addStudent() async {
    Map<String, dynamic> studentInfoMap = {
      "student_name": studentName.text,
      "email": email.text,
      "phone": phone.text,
    };
    try {
      await DataMethod().addStudent(studentInfoMap);
      clearForm(); //
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Student added successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding student: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              "Student Info",
              style: TextStyle(fontSize: 30),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  controller: studentName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Student Name',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Phone',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await addStudent();
                  },
                  child: Text("Submit"),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyStudentList()));
                    },
                    child: Text("View Student"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
