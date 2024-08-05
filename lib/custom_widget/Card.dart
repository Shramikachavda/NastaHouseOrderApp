import 'package:flutter/material.dart';

class customcard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String avtarimage;

  const customcard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.avtarimage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 2, color: Color.fromARGB(255, 250, 229, 112)),
              borderRadius: BorderRadius.circular(12)),
          child: Container(
            height: 220,
            width: 180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 160,
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 27, 30, 37)),
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(avtarimage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 27, 30, 37)),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                            fontSize: 5,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 27, 30, 37)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
