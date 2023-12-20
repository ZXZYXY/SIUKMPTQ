// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siukmptq/layar_infodftar.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
  );
}

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.grey[700],
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container signInSignUpBtn(BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black12;
            }
            return const Color.fromARGB(255, 214, 214, 214);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
      child: Text(
        isLogin ? 'MASUK' : 'DAFTAR',
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}

void storeUserData(User? user, String nickname, int? divisi, String username,
    String prodi) async {
  try {
    if (user != null) {
      String defaultRole = "nonmember";
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'nickname': nickname,
        'role': defaultRole,
        'divisi': divisi,
        'username': user.email,
        'prodi': prodi,
      });
    }
  } catch (e) {
    // Handle errors
    print("Error storing user data: $e");
  }
}

Future<void> getUserData(String userId) async {
  try {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (documentSnapshot.exists) {
      // User data found
      Map<String, dynamic> userData =
          documentSnapshot.data() as Map<String, dynamic>;
      print("Username: ${userData['username']}");
      print("Email: ${userData['email']}");
      // Access other fields as needed
    } else {
      // User data not found
      print("User data not found");
    }
  } catch (error) {
    print("Error retrieving user data: $error");
  }
}

Future<void> loginWithUsername(String username, BuildContext context) async {
  try {
    print('Checking for user with username: $username');

    // Query Firestore to get user data based on the entered username
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    print('Query result: ${querySnapshot.docs}');

    if (querySnapshot.docs.isNotEmpty) {
      // User with the entered username found
      print('User found. Logging in...');
      // Implement your login logic here
      // For example, navigate to another screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Layar_InfoDaftar(),
        ),
      );
    } else {
      // User with the entered username not found
      print('User not found');
      // You can show an error message or perform any other actions
    }
  } catch (error) {
    // Handle errors
    print('Error logging in: $error');
  }
}

Future<bool> checkSpecialPrivileges(User user) async {
  try {
    // Get the user document from Firestore
    DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(user.uid)
        .get();

    // Check if the user has admin privileges
    bool isAdmin = userDoc.get('isAdmin') ?? false;

    print('User ID: ${user.uid}, isAdmin: $isAdmin');

    return isAdmin;
  } catch (e) {
    print('Error checking special privileges: $e');
    return false;
  }
}

Future<void> grantAdminPrivileges(String userId) async {
  // Update the user document in Firestore to set isAdmin to true
  await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .update({'isAdmin': true});
}
