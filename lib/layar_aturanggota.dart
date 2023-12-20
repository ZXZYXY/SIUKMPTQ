import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:siukmptq/reusable/reusable.dart';

class Layar_Atragta extends StatefulWidget {
  const Layar_Atragta({Key? key});

  @override
  State<Layar_Atragta> createState() => _Layar_AtragtaState();
}

class _Layar_AtragtaState extends State<Layar_Atragta> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atragta Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Enter Username',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  String username = _usernameController.text.trim();

                  // Get the current user
                  User? currentUser = _auth.currentUser;

                  if (currentUser != null) {
                    // Check if the current user has admin privileges
                    bool isAdmin = await checkSpecialPrivileges(currentUser);

                    if (isAdmin) {
                      // Update the user's role to "member" in Firestore
                      await _firestore
                          .collection('users')
                          .where('username', isEqualTo: username)
                          .get()
                          .then((QuerySnapshot querySnapshot) {
                        querySnapshot.docs.forEach((DocumentSnapshot document) {
                          document.reference.update({
                            'role': 'member',
                            // Add more fields as needed
                          });
                        });
                      });

                      // Show a success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Role updated to "member" successfully.'),
                        ),
                      );
                    } else {
                      // Show an error message if the current user is not an admin
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('You do not have admin privileges.'),
                        ),
                      );
                    }
                  } else {
                    // Handle the case where the user is not signed in
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('User not signed in.'),
                      ),
                    );
                  }
                } catch (error) {
                  // Handle errors
                  print('Error updating role: $error');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error updating role. Please try again.'),
                    ),
                  );
                }
              },
              child: const Text('Change User Role to Member'),
            ),
          ],
        ),
      ),
    );
  }
}
