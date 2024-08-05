import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_order/LogIn.dart';

class AuthHelper {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> signOut(BuildContext context) async {
    // Show alert dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to log out?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Logout"),
              onPressed: () async {
                try {
                  await _auth.signOut(); // Sign out user from Firebase
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LogIn())); // Navigate to login screen
                } catch (e) {
                  print("Error signing out: $e");
                  // Optionally, show an error message or handle the error
                }
              },
            ),
          ],
        );
      },
    );
  }
}

//dialog  box
class alertBox {
  static CustomAlertBox(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(title: Text(text), actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Okay'))
          ]);
        });
  }
}
