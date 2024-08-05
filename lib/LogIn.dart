import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_order/ForgotPass.dart';
import 'package:food_order/RegisterPage.dart';
import 'package:food_order/admin_pages/Adminpage.dart';

import 'package:food_order/custom_widget/TextField.dart';
import 'package:food_order/customer_pages/customerpage.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogIn();
}

class _LogIn extends State<LogIn> {
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 229, 112),
        title: Text(''),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromARGB(255, 27, 30, 37),
        alignment: AlignmentDirectional.bottomStart,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              textAlign: TextAlign.center,
              ' WELCOME TO ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Color.fromARGB(255, 250, 229, 112),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              textAlign: TextAlign.left,
              '  DERANI JETHANI NASTAHOUSE !!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromARGB(255, 250, 229, 112),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Textfield(
                                suffixIcon: Icons.email,
                                Controller: Email,
                                hintText: 'Enter your E-mail',
                                lable: 'Enter your E-mail',
                                textInputType: TextInputType.emailAddress,
                                obscureText: false,
                                obscuringCharacter: '',
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextField(
                                  controller: Password,
                                  obscureText: _obscureText,
                                  obscuringCharacter: '*',
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          icon: Icon(_obscureText
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                          onPressed: () => {
                                                setState(() {
                                                  _obscureText = !_obscureText;
                                                })
                                              }),
                                      labelText: 'Enter your Password',
                                      hintText: "Enter your Password",
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(width: 2)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                            width: 3,
                                            color: Color.fromARGB(
                                                255, 250, 229, 112),
                                          ))),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgotPass()));
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 27, 30, 37)),
                            )),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 20, color: Colors.black12)
                                ],
                                color: Color.fromARGB(255, 27, 30, 37)),
                            child: Center(
                              child: TextButton(
                                  onPressed: () {
                                    print('done');

                                    _login();
                                    //  route();
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Color.fromARGB(255, 250, 229, 112),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return RegisterPage();
                              }));
                            },
                            child: Text(
                              'Not Register yet? Register',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 27, 30, 37),
                              ),
                            )),
                      ],
                    ),
                  )),
            ),
            // login button
          ],
        ),
      ),
    );
  }

  Future route() async {
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "admin" &&
            documentSnapshot.get('email') == "dj1@gmail.com") {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (ctx) => Admin(),
          ));
        } else if (documentSnapshot.get('role') == 'customer') {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (ctx) => Customer(),
          ));
        } else {
          _showErrorDialog(
              "You Can't Login As Admin, Change Your Selected Role As Customer.");
        }
      } else {
        _showErrorDialog('User data not found');
      }
    });
  }
//

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  //
  void _login() async {
    String email = Email.text.trim();
    String password = Password.text.trim();
    if (email == '' || password == '') {
      _showErrorDialog("E-mail and Password can't be null");
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await route();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showErrorDialog('No user found for that email.');
      }
      if (e.code == 'wrong-password') {
        _showErrorDialog('Wrong password provided for that user.');
      }

      _showErrorDialog('Athentication Error');
    } catch (ex) {
      _showErrorDialog('Some Error Occured ${ex.toString()}');
    }
  }
}
