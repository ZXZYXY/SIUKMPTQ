import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:siukmptq/utilitty/kolor.dart';

class GetActivitiesPage2 extends StatefulWidget {
  @override
  _GetActivitiesPage2State createState() => _GetActivitiesPage2State();
}

class _GetActivitiesPage2State extends State<GetActivitiesPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(" Info Pendaftaran 2 "),
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
          child: StreamBuilder(
            // Replace 'activities2' with the desired collection name for the second page
            stream: FirebaseFirestore.instance
                .collection('activities2')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text('Tidak ada kegiatan.'),
                );
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  return Card(
                    elevation: 3, // Add elevation for a card-like appearance
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text(
                        data['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        'Timestamp: ${data['timestamp']}',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                      // Add more styling options here if needed
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ));
  }
}
