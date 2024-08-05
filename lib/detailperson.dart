import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonDetailScreen extends StatefulWidget {
  @override
  _PersonDetailScreenState createState() => _PersonDetailScreenState();
}

class _PersonDetailScreenState extends State<PersonDetailScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String name = '';
  String email = '';
  String phone = '';

  String originalName = ''; // Store original values for comparison
  String originalEmail = '';
  String originalPhone = '';

  void _fetchPersonDetails() async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        setState(() {
          name = originalName = documentSnapshot.get('name');
          email = originalEmail = documentSnapshot.get('email');
          phone = originalPhone = documentSnapshot.get('phone');
        });
      }
    } catch (e) {
      print('Error fetching person details: $e');
    }
  }

  void _updatePersonDetails(
      String newName, String newEmail, String newPhone) async {
    if (newName == originalName &&
        newEmail == originalEmail &&
        newPhone == originalPhone) {
      // Check if there are any changes
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: const Color.fromARGB(255, 250, 229, 112),
        content: Text('No changes detected',
            style: TextStyle(color: Color.fromARGB(255, 27, 30, 37))),
      ));
      return; // Exit the method without updating
    }

    try {
      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({
        'name': newName,
        'email': newEmail,
        'phone': newPhone,
      });
      setState(() {
        name = originalName = newName; // Update original values
        email = originalEmail = newEmail;
        phone = originalPhone = newPhone;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: const Color.fromARGB(255, 250, 229, 112),
        content: Text('Details updated successfully',
            style: TextStyle(color: Color.fromARGB(255, 27, 30, 37))),
      ));
    } catch (e) {
      print('Error updating person details: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('Failed to update details'),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPersonDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Person Details'),
        backgroundColor: const Color.fromARGB(255, 250, 229, 112),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Name:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: TextEditingController(text: name),
                  onChanged: (value) => name = value,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 2)),
                      labelText: 'Enter your Name',
                      hintText: 'Enter your Name',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 250, 229, 112),
                            width: 3),
                      )),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Email:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: TextEditingController(text: email),
                  onChanged: (value) => email = value,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 2)),
                      labelText: 'Enter your Email',
                      hintText: 'Enter your Email',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 250, 229, 112),
                            width: 3),
                      )),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Phone Number:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: TextEditingController(text: phone),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => phone = value,
                  decoration: InputDecoration(
                      icon: Icon(Icons.phone),
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 2)),
                      labelText: 'Enter your Phone Number',
                      hintText: 'Enter your Phone Number',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 250, 229, 112),
                            width: 3),
                      )),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(blurRadius: 20, color: Colors.black12)
                      ],
                      color: Color.fromARGB(255, 27, 30, 37)),
                  child: Center(
                    child: TextButton(
                        onPressed: () {
                          print('done');
                          _updatePersonDetails(name, email, phone);
                        },
                        child: Text(
                          'Update Detail',
                          style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(255, 250, 229, 112),
                          ),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
