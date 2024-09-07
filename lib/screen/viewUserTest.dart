import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/composable/getCollection.dart';
import 'package:flutter_firebase_crud/composable/getCollectionById.dart';
import 'package:flutter_firebase_crud/composable/getCollectionSearch.dart';
import 'package:flutter_firebase_crud/composable/useCollection.dart';

class MyViewUser extends StatefulWidget {
  const MyViewUser({super.key});

  @override
  State<MyViewUser> createState() => _MyViewUserState();
}

class _MyViewUserState extends State<MyViewUser> {
  final GetCollectionService _collectionService = GetCollectionService();
  final FirestoreService _firestoreService = FirestoreService();
  final Getcollectionbyid _getcollectionbyid = Getcollectionbyid();
  final Getcollectionsearch _getcollectionsearch = Getcollectionsearch();

  List<Map<String, dynamic>> _users = [];
  List<Map<String, dynamic>> _filteredUsers = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  // Fetch user data from Firestore collection
  void _loadUsers() async {
    List<Map<String, dynamic>> users = await _collectionService.getCollection('users'); // 'users' is the collection name
    setState(() {
      _users = users;
      _filteredUsers = users;
      _isLoading = false;
    });
  }
  // Delete User
  void _deleteUser(String docId) async {
    await _firestoreService.deleteDocument('users', docId);
    _loadUsers(); // Reload users after deletion
  }

  //  search query
  void _searchUsers(String query) async {
    List<Map<String, dynamic>> users = await _getcollectionsearch.searchCollection('users', 'userName', query);
    setState(() {
      _filteredUsers = users;
    });
  }

  // Show dialog to update user
  void _showUpdateDialog(String docId) async {
    Map<String, dynamic>? user = await _getcollectionbyid.getDocumentById('users', docId);

    if (user != null) {
      final TextEditingController _nameController = TextEditingController(text: user['userName']);
      final TextEditingController _emailController = TextEditingController(text: user['email']);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update User'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  Map<String, dynamic> updatedData = {
                    'userName': _nameController.text.toLowerCase(),
                    'email': _emailController.text,
                  };
                  await _firestoreService.updateDocument('users', docId, updatedData);
                  Navigator.of(context).pop(); // Close dialog
                  _loadUsers(); // Reload users after update
                },
                child: Text('Update'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Users'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
                _searchUsers(query); // Search as user types
              },
              decoration: InputDecoration(
                hintText: 'Search by name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _filteredUsers.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> user = _filteredUsers[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(user['userName'][0].toUpperCase()), // First letter of user's name
            ),
            title: Text(user['email'] ?? 'No email'),
            subtitle: Text(user['password'] ?? 'No Password'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _showUpdateDialog(user['id']);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteUser(user['id']);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
