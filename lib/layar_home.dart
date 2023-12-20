import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:siukmptq/layar_keg1.dart';
import 'package:siukmptq/layar_keg2.dart';
import 'package:siukmptq/utilitty/kolor.dart';

class Layar_Home extends StatefulWidget {
  const Layar_Home({Key? key}) : super(key: key);

  @override
  State<Layar_Home> createState() => _Layar_HomeState();
}

class _Layar_HomeState extends State<Layar_Home> {
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
        title: const Text("Home"),
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
              height: 95,
            ), // Spacer to position the box under the app bar
            _userData != null
                ? Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nama    : ${_userData!['nickname']}'),
                        Text('NIM       : ${_user!.email}'),
                        Text('Prodi     : ${_userData!['prodi']}'),
                        Text('Divisi     : ${_userData!['divisi']}'),
                        // Add more fields as needed
                      ],
                    ),
                  )
                : const CircularProgressIndicator(),
            Container(
              padding: const EdgeInsets.all(11.0),
              margin: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // First StreamBuilder and DataTable
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('activities')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text('Tidak ada kegiatan.'),
                        );
                      }

                      List<DataRow> rows =
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                data['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                data['date'],
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            DataCell(
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.deepOrange),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              GetActivitiesPage(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Detail',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList();

                      return DataTable(
                        columns: const [
                          DataColumn(label: Text('Kategori')),
                          DataColumn(label: Text('Keterangan')),
                          DataColumn(label: Text('      Detail')),
                          // Add more DataColumn for additional headers if needed
                        ],
                        rows: rows,
                      );
                    },
                  ),
                  // Second StreamBuilder and DataTable
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('activities2')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text('Tidak ada kegiatan.'),
                        );
                      }

                      List<DataRow> rows =
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                data['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                data['date'],
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            DataCell(
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.deepOrange),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              GetActivitiesPage2(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Detail',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList();

                      return DataTable(
                        columns: [
                          DataColumn(
                            label: Container(
                              padding: EdgeInsets.all(
                                  10.0), // Adjust the padding as needed
                              child: Text('------------'),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              padding: EdgeInsets.all(
                                  10.0), // Adjust the padding as needed
                              child: Text('-----------'),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              padding: EdgeInsets.all(
                                  10.0), // Adjust the padding as needed
                              child: Text('-----------'),
                            ),
                          ),
                          // Add more DataColumn for additional headers if needed
                        ],
                        rows:
                            rows, // Assuming you have the rows defined elsewhere in your code
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
