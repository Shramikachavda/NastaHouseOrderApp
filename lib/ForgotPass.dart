import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_order/auth_helper.dart';
import 'package:food_order/custom_widget/TextField.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  TextEditingController email = TextEditingController();

  resetpassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email.text.toString());
      alertBox.CustomAlertBox(context, 'Password Email Reset has been Sent !');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        alertBox.CustomAlertBox(context, 'User Not Found !');
      }
    } catch (ex) {
      alertBox.CustomAlertBox(context, 'Something Went Wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 250, 229, 112),
        title: Text('Forgot Password'),
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
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
              '  PASSWORD RECOVERY',
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
              '  ENTER EMAIL',
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
                //height: 400,
                //   width: 500,
                //  color: Colors.white,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                    ),
                    Center(
                      child: Textfield(
                        Controller: email,
                        hintText: 'Enter Email',
                        lable: 'Enter Email',
                        suffixIcon: Icons.email,
                        obscureText: false,
                        textInputType: TextInputType.text,
                        obscuringCharacter: '',
                      ),
                    ),
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
                                resetpassword();
                              },
                              child: Text(
                                'Send Email',
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
          ],
        ),
      ),
    );
  }
}
