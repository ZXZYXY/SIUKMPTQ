// ignore_for_file: unused_import, camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siukmptq/layar_infodftar.dart';
import 'package:siukmptq/reusable/reusable.dart';
import 'package:siukmptq/utilitty/kolor.dart';

class Layar_Login extends StatefulWidget {
  const Layar_Login({Key? key}) : super(key: key);

  @override
  _Layar_LoginState createState() => _Layar_LoginState();
}

class _Layar_LoginState extends State<Layar_Login> {
  final TextEditingController _usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Periksa Pendaftaran"),
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Username',
                    filled: true,
                    fillColor:
                        Colors.white70, // Set your desired background color
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black12;
                        }
                        return const Color.fromARGB(255, 214, 214, 214);
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)))),
                  onPressed: () async {
                    // Call the function to check and login
                    await loginWithUsername(_usernameController.text, context);
                  },
                  child: const Text(
                    "Periksa",
                    style: const TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
