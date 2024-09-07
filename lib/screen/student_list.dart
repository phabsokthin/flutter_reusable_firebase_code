import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_crud/service/database.dart';

class MyStudentList extends StatefulWidget {
  const MyStudentList({super.key});

  @override
  State<MyStudentList> createState() => _MyStudentListState();
}

class _MyStudentListState extends State<MyStudentList> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> studentStream;

  @override
  void initState() {
    super.initState();
    studentStream = DataMethod().getStudents(); // Updated method name
  }

//modal update
  void _showUpdateDialog(BuildContext context, String docId, Map<String, dynamic> studentData) {
    TextEditingController nameController = TextEditingController(text: studentData['student_name']);
    TextEditingController phoneController = TextEditingController(text: studentData['phone']);
    TextEditingController emailController = TextEditingController(text: studentData['email']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update Student Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Student Name"),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: "Phone"),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                Map<String, dynamic> updatedData = {
                  'student_name': nameController.text,
                  'phone': phoneController.text,
                  'email': emailController.text,
                };
                await DataMethod().updateStudent(docId, updatedData);
                Navigator.of(context).pop();
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  //table sudent
  Widget allStudentDetail() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: studentStream,
      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No students found"));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var studentDoc = snapshot.data!.docs[index];
            var studentData = studentDoc.data();

            return ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(studentData['student_name'] ?? 'No student name'),
                  Text(studentData['phone'] ?? "No Phone"),
                  Text(studentData['email'] ?? "No Email"),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showUpdateDialog(context, studentDoc.id, studentData);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _showDeleteConfirmationDialog(context, studentDoc.id);
                        },
                      )

                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }


//modal dialog
  void _showDeleteConfirmationDialog(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this student?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                try {
                  await DataMethod().deleteStudent(docId);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Student deleted successfully')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error deleting student: $e')),
                  );
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Student List")),
        body: Container(
          margin: const EdgeInsets.all(20),
          child: allStudentDetail(),
        ),
      ),
    );
  }
}
