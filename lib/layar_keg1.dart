import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:siukmptq/utilitty/kolor.dart';

class GetActivitiesPage extends StatefulWidget {
  @override
  _GetActivitiesPageState createState() => _GetActivitiesPageState();
}

class _GetActivitiesPageState extends State<GetActivitiesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(" Info Kegiatan "),
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
            stream:
                FirebaseFirestore.instance.collection('activities').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('Tidak ada kegiatan.'),
                );
              }
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  return Card(
                    elevation: 3, // Add elevation for a card-like appearance
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text(
                        data['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'Date: ${data['date']}',
                            style: const TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 25),
                          Text(
                            'Deskripsi : ${data['isi']}', // Add your additional field here
                            style: const TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
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
