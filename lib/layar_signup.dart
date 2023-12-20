// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siukmptq/layar_cekakun.dart';
import 'package:siukmptq/layar_home.dart';
import 'package:siukmptq/layar_signin.dart';
import 'package:siukmptq/reusable/reusable.dart';
import 'package:siukmptq/utilitty/kolor.dart';

class Layar_Signup extends StatefulWidget {
  const Layar_Signup({Key? key}) : super(key: key);

  @override
  _Layar_SignupState createState() => _Layar_SignupState();
}

class _Layar_SignupState extends State<Layar_Signup> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _personidTextController = TextEditingController();
  final TextEditingController _prodiTextController = TextEditingController();
  int? _divisi;
  bool _showGenderOptions = false; // Flag to control visibility

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Akun Telah Terbuat'),
          content: const Text('Akun kamu sudah terbuat'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Daftar",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.2,
              20,
              0,
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  "Masukan Nama",
                  Icons.account_balance_rounded,
                  false,
                  _personidTextController,
                ),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField(
                  "Masukan NIM",
                  Icons.person_2_rounded,
                  false,
                  _usernameTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  "Masukan Password",
                  Icons.house_sharp,
                  true,
                  _passwordTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  "Masukan Prodi",
                  Icons.house_sharp,
                  false,
                  _prodiTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showGenderOptions = !_showGenderOptions;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      title: const Text(" Pilih Divisi "),
                      subtitle: _showGenderOptions
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                      value: 1,
                                      groupValue: _divisi,
                                      onChanged: (value) {
                                        setState(() {
                                          _divisi = value;
                                        });
                                      },
                                    ),
                                    const Text("Tilawah"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 2,
                                      groupValue: _divisi,
                                      onChanged: (value) {
                                        setState(() {
                                          _divisi = value;
                                        });
                                      },
                                    ),
                                    const Text("Tartil"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 3,
                                      groupValue: _divisi,
                                      onChanged: (value) {
                                        setState(() {
                                          _divisi = value;
                                        });
                                      },
                                    ),
                                    const Text("Syarhil"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 4,
                                      groupValue: _divisi,
                                      onChanged: (value) {
                                        setState(() {
                                          _divisi = value;
                                        });
                                      },
                                    ),
                                    const Text("Fahmil"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 5,
                                      groupValue: _divisi,
                                      onChanged: (value) {
                                        setState(() {
                                          _divisi = value;
                                        });
                                      },
                                    ),
                                    const Text("Hifdzil"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 6,
                                      groupValue: _divisi,
                                      onChanged: (value) {
                                        setState(() {
                                          _divisi = value;
                                        });
                                      },
                                    ),
                                    const Text("Kaligrafi"),
                                  ],
                                ),
                              ],
                            )
                          : const Text("Klik untuk pilih divisi"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                signInSignUpBtn(context, false, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Layar_Signin()));
                  // Validate fields and proceed with signup
                  if (_usernameTextController.text.isEmpty ||
                      _passwordTextController.text.isEmpty ||
                      _personidTextController.text.isEmpty ||
                      _prodiTextController.text.isEmpty ||
                      _divisi == null) {
                    // Show error message or handle validation as needed
                    print("Tolong Diisi semua");
                    return;
                  }

                  String username = _usernameTextController.text;
                  String nickname = _personidTextController.text;
                  String prodi = _prodiTextController.text;

                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: "$username@example.com",
                    password: _passwordTextController.text,
                  )
                      .then((userCredential) {
                    print("Akun Terbuat");
                    storeUserData(userCredential.user, nickname, _divisi,
                        username, prodi);
                    _showSuccessDialog();
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
                cekAkunOption()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row cekAkunOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(" Sudah Punya akun ? ",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Layar_Login()));
          },
          child: const Text(
            "Periksa",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
