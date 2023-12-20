import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:siukmptq/layar_admin.dart';
import 'package:siukmptq/layar_home.dart';
import 'package:siukmptq/layar_signup.dart';
import 'package:siukmptq/reusable/reusable.dart';
import 'package:siukmptq/utilitty/kolor.dart';

class Layar_Signin extends StatefulWidget {
  const Layar_Signin({Key? key});

  @override
  State<Layar_Signin> createState() => _Layar_SigninState();
}

class _Layar_SigninState extends State<Layar_Signin> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();

  Future<bool> checkUserRole(User user) async {
    try {
      // Reference to the user's document in Firestore
      DocumentReference<Map<String, dynamic>> userRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      // Get the user's document data
      DocumentSnapshot<Map<String, dynamic>> userDoc = await userRef.get();

      // Check if the 'role' field exists and has the value 'member'
      if (userDoc.exists && userDoc.data()!['role'] == 'member') {
        return true; // User has 'member' role
      } else {
        return false; // User doesn't have 'member' role
      }
    } catch (error) {
      print("Error checking user role: $error");
      return false; // Assume an error means the user doesn't have 'member' role
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("ba8511"),
          hexStringToColor("b82e00")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/logobaru.png"),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField("Masukan NIM", Icons.person_2, false,
                    _usernameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                    "Masukan Code", Icons.lock, true, _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                signInSignUpBtn(context, true, () async {
                  String username = _usernameTextController.text;
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: "$username@example.com",
                            password: _passwordTextController.text);

                    // After successful sign-in, check for special account privileges
                    User? signedInUser = userCredential.user;
                    if (signedInUser != null) {
                      bool hasSpecialPrivileges =
                          await checkSpecialPrivileges(signedInUser);

                      if (hasSpecialPrivileges) {
                        // Navigate to a special admin/dashboard screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Layar_Admin(),
                          ),
                        );
                      } else {
                        // Check for 'member' role before navigating to Layar_Home
                        bool isMember = await checkUserRole(signedInUser);

                        if (isMember) {
                          // Navigate to the regular home screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Layar_Home(),
                            ),
                          );
                        } else {
                          // Show an error dialog if the user doesn't have the 'member' role
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Error"),
                                content: const Text(
                                    "Anda tidak memiliki izin untuk masuk."),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    }
                  } catch (error) {
                    print("Error: $error");
                    // Show an error dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Error"),
                          content: const Text("AKUN anda belum terdaftar"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }),
                signUpOption()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(" Belum Punya Akun ? ",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Layar_Signup()));
          },
          child: const Text(
            "Daftar",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
