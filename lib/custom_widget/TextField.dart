import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  final TextEditingController Controller;
  final IconData suffixIcon;
  final String hintText;
  final String lable;
  final TextInputType textInputType;
  final bool obscureText;
  final String obscuringCharacter;

  const Textfield(
      {super.key,
      required this.Controller,
      required this.suffixIcon,
      required this.hintText,
      required this.lable,
      required this.textInputType,
      required this.obscuringCharacter,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: Controller,
        keyboardType: textInputType,
        obscureText: obscureText,
        obscuringCharacter:
            obscuringCharacter.length == 1 ? obscuringCharacter : '•',
        decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(suffixIcon),
              onPressed: () {
                print('hi');
              },
            ),
            border: OutlineInputBorder(borderSide: BorderSide(width: 2)),
            labelText: lable,
            hintText: hintText,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 250, 229, 112), width: 3),
            )),
      ),
    );
  }
}
