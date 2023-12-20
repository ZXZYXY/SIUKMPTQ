// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siukmptq/layar_addkeg.dart';
import 'package:siukmptq/layar_aturanggota.dart';
import 'package:siukmptq/layar_signin.dart';
import 'package:siukmptq/utilitty/kolor.dart';

class Layar_Admin extends StatefulWidget {
  const Layar_Admin({Key? key}) : super(key: key);

  @override
  State<Layar_Admin> createState() => _Layar_AdminState();
}

class _Layar_AdminState extends State<Layar_Admin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Admin"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [hexStringToColor("ba8511"), hexStringToColor("b82e00")],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
                height: 95), // Spacer to position the box under the app bar
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Settings Kegiatan"),
                  const SizedBox(height: 10), // Adjust the height for spacing
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddActivityPage(),
                        ),
                      );
                      print('Button Clicked');
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepOrange),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.all(1),
                      ),
                    ),
                    child: const Text(
                      "Go",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text("Mengatur Status Anggota"),
                  const SizedBox(height: 10), // Adjust the height for spacing
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Layar_Atragta(),
                        ),
                      );
                      print('Button Clicked');
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepOrange),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.all(1),
                      ),
                    ),
                    child: const Text(
                      "Go",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(), // Add Spacer to push the sign-out button to the bottom
            Container(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () async {
                  await _auth.signOut();
                  // After signing out, you might want to navigate to the login screen
                  // You can use Navigator.pushReplacement for that
                  FirebaseAuth.instance.signOut();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                child: const Text(
                  "Sign Out",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
