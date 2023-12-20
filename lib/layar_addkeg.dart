import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddActivityPage extends StatefulWidget {
  @override
  _AddActivityPageState createState() => _AddActivityPageState();
}

class _AddActivityPageState extends State<AddActivityPage> {
  final TextEditingController _activityController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _isiController = TextEditingController();

  // Declare a variable to store the selected collection name
  String selectedCollection = 'activities';

  // Function to show the date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    ))!;
    if (picked != DateTime.now()) {
      setState(() {
        _dateController.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Kegiatan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _activityController,
              decoration: InputDecoration(labelText: 'Judul Kegiatan'),
            ),
            TextFormField(
              controller: _dateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Tanggal Kegiatan',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ),
            ),
            TextField(
              controller: _isiController,
              decoration: InputDecoration(labelText: 'Isi Kegiatan'),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedCollection,
              items: [
                'activities',
                'activities2'
              ] // Add more collection names as needed
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedCollection = value!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Panggil fungsi untuk menambah kegiatan ke Firebase
                _addActivityToFirebase(
                  _activityController.text,
                  _dateController.text,
                  _isiController.text,
                  selectedCollection,
                );
              },
              child: Text('Tambah Kegiatan'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Panggil fungsi untuk menghapus kegiatan dari Firebase
                _deleteActivityFromFirebase(
                  _activityController.text,
                  selectedCollection,
                );
              },
              child: Text('Hapus Kegiatan'),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk menambah kegiatan ke Firebase
  void _addActivityToFirebase(
    String activityName,
    String date,
    String isi,
    String collectionName,
  ) {
    FirebaseFirestore.instance.collection(collectionName).add({
      'name': activityName,
      'timestamp': FieldValue.serverTimestamp(),
      'date': date,
      'isi': isi,
      // Add more fields as needed
    });
  }

  // Fungsi untuk menghapus kegiatan dari Firebase
  void _deleteActivityFromFirebase(String activityName, String collectionName) {
    // Query the collection to find the document with the specified name
    FirebaseFirestore.instance
        .collection(collectionName)
        .where('name', isEqualTo: activityName)
        .get()
        .then((querySnapshot) {
      // Delete the document if found
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }
}
