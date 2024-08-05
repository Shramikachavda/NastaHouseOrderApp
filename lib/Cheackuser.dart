import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_order/LogIn.dart';
import 'package:food_order/admin_pages/Adminpage.dart';
import 'package:food_order/auth_helper.dart';
import 'package:food_order/customer_pages/customerpage.dart';

class Cheackuser extends StatefulWidget {
  const Cheackuser({Key? key}) : super(key: key);

  @override
  State<Cheackuser> createState() => _CheackuserState();
}

class _CheackuserState extends State<Cheackuser> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (documentSnapshot.exists) {
          if (documentSnapshot.get('role') == "admin" &&
              documentSnapshot.get('email') == 'dj1@gmail.com') {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Admin()),
            );
          } else if (documentSnapshot.get('role') == "customer") {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Customer()),
            );
          } else {
            alertBox.CustomAlertBox(
                context, 'You are not Able to Login As Admin');
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LogIn()));
          }
        } else {
          print('Document does not exist on the database');
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LogIn()),
          );
        }
      } catch (e) {
        print('Error fetching user data: $e');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LogIn()),
        );
      }
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LogIn()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Customize as needed
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
