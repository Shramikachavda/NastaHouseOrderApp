import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_order/LogIn.dart';
import 'package:food_order/custom_widget/TextField.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailemail = TextEditingController();
  TextEditingController passwordpassword = TextEditingController();
  TextEditingController namename = TextEditingController();
  TextEditingController number = TextEditingController();

  String? _selectedRole;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    var textButton = TextButton(
        child: Text(
          'Register',
          style: TextStyle(
            fontSize: 25,
            color: Color.fromARGB(255, 250, 229, 112),
          ),
        ),
        onPressed: () async {
          _register();
        });
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page'),
        backgroundColor: Color.fromARGB(255, 250, 229, 112),
      ),
      body: Container(
        color: Color.fromARGB(255, 27, 30, 37),
        alignment: AlignmentDirectional.bottomStart,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              textAlign: TextAlign.center,
              ' REGISTER YOUR SELF HERE ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Color.fromARGB(255, 250, 229, 112),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Expanded(
              child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Textfield(
                              suffixIcon: Icons.short_text_sharp,
                              Controller: namename,
                              hintText: 'Enter your Name',
                              lable: 'Enter your Name',
                              textInputType: TextInputType.name,
                              obscureText: false,
                              obscuringCharacter: '',
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Textfield(
                              suffixIcon: Icons.email,
                              Controller: emailemail,
                              hintText: 'Enter your E-mail',
                              lable: 'Enter your E-mail',
                              textInputType: TextInputType.emailAddress,
                              obscureText: false,
                              obscuringCharacter: '',
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Textfield(
                              suffixIcon: Icons.phone,
                              Controller: number,
                              hintText: 'Enter your Phone Number',
                              lable: 'Enter your Phone Number',
                              textInputType: TextInputType.number,
                              obscureText: false,
                              obscuringCharacter: '',
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              margin: EdgeInsets.all(10),

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  value: _selectedRole,
                                  iconSize: 30,
                                  isExpanded: true,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedRole = newValue!;
                                    });
                                  },
                                  items: [
                                    DropdownMenuItem(
                                      value: 'admin',
                                      child: Text('admin'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'customer',
                                      child: Text('customer'),
                                    ),
                                    // Add more roles as needed
                                  ],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        width: 3,
                                        color:
                                            Color.fromARGB(255, 250, 229, 112),
                                      ),
                                    ),
                                    labelText: 'Select Role',
                                  ),
                                ),
                              ),
//
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                controller: passwordpassword,
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
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          width: 3,
                                          color: Color.fromARGB(
                                              255, 250, 229, 112),
                                        ))),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
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
                              child: textButton,
                            ),
                            //
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return LogIn();
                              }));
                            },
                            child: Text(
                              'Already Register ? Go to Login Page',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 27, 30, 37),
                              ),
                            )),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  //
  void _register() async {
    String name = namename.text.trim();
    String email = emailemail.text.trim();
    String Number = number.text.trim();

    // Validate inputs
    if (name.isEmpty ||
        email.isEmpty ||
        Number.isEmpty ||
        _selectedRole == null) {
      _showErrorDialog('All Fields are Required to Fill');
      return;
    }

    // Email validation
    if (!isValidEmail(email)) {
      _showErrorDialog("Enter a valid email address");
      return;
    }

    // Validate email starts with a character and contains at least one number
    if (!email.startsWith(RegExp(r'[a-zA-Z]')) ||
        !email.contains(RegExp(r'\d'))) {
      _showErrorDialog(
          "Email must start with a character and contain at least one number");
      return;
    }

    // Number validation
    if (!isValidPhoneNumber(Number)) {
      _showErrorDialog("Enter a valid phone number");
      return;
    }

    // Password validation
    String password = passwordpassword.text.toString();
    if (!isValidPassword(password)) {
      _showErrorDialog("Password must be at least 6 characters long");

      return;
    }

    try {
      // 1. Register user with Firebase Auth
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: passwordpassword.text.toString(),
      );

      // 2. Add user data to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'name': name,
        'email': email,
        'phone': Number,
        'role': _selectedRole,
      });

      // 3. Navigate to success page or home screen
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LogIn();
      })); // Replace with your route
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _showErrorDialog('weak-password Error');
      }
      if (e.code == 'email-already-in-use') {
        _showErrorDialog('Email is Already in Use Error');
      }
      if (e.code == 'invalid-email') {
        _showErrorDialog('Email Formating is Invalid');
      }

      _showErrorDialog('Failed to register: $e');
    } catch (e) {
      _showErrorDialog('Failed to register: $e');

      print('Error registering user: $e');
    }
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool isValidPhoneNumber(String Number) {
    // Simple phone number validation (10 digits)
    String pattern = r'^[0-9]{10}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(Number);
  }

  bool isValidPassword(String password) {
    // Simple password validation (at least 6 characters)
    return password.length >= 6;
  }

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
}
