import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:siukmptq/utilitty/kolor.dart';

class Layar_InfoDaftar extends StatefulWidget {
  const Layar_InfoDaftar({super.key});

  @override
  State<Layar_InfoDaftar> createState() => _Layar_InfoDaftarState();
}

class _Layar_InfoDaftarState extends State<Layar_InfoDaftar> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _getUserData();
  }

  Future<void> _getUserData() async {
    if (_user != null) {
      DocumentSnapshot<Map<String, dynamic>> userData =
          await _firestore.collection('users').doc(_user!.uid).get();

      setState(() {
        _userData = userData.data();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(" Info Pendaftaran "),
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
            _userData != null
                ? Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(20.0),
                    margin: const EdgeInsets.all(20.0),
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
                        Text('Nickname: ${_userData!['nickname']}'),
                        Text('Email: ${_user!.email}'),
                        Text('Prodi: ${_userData!['prodi']}'),
                        Text('Divisi: ${_userData!['divisi']}'),
                        // Add more fields as needed
                      ],
                    ),
                  )
                : const CircularProgressIndicator(),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.all(20.0),
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
              child: DataTable(
                columns: const [
                  DataColumn(
                      label: Text(
                    'Tentang',
                    textAlign: TextAlign.center,
                  )),
                  DataColumn(
                      label: Text(
                    'Keterangan',
                    textAlign: TextAlign.center,
                  )),
                ],
                rows: const [
                  DataRow(
                    cells: [
                      DataCell(Text('Jadwal')),
                      DataCell(Text('10 Juni 2025')),
                    ],
                  ),

                  DataRow(
                    cells: [
                      DataCell(Text('Hasil')),
                      DataCell(Text('Belum Ditentukan')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Kode Anggota')),
                      DataCell(Text('Belum Ditentukan')),
                    ],
                  ),
                  // Add more rows as needed
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
