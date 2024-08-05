import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:food_order/admin_pages/AddItem.dart';
import 'package:food_order/admin_pages/orderdetail.dart';
import 'package:food_order/admin_pages/person.dart';
import 'package:food_order/auth_helper.dart';
import 'package:food_order/custom_widget/Card.dart';
import 'package:food_order/customer_pages/customerpage.dart';
import 'package:food_order/detailperson.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ADMIN PAGE'),
          backgroundColor: const Color.fromARGB(255, 250, 229, 112),
        ),
        drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 27, 30, 37),
              ),
              accountName: user != null
                  ? Text(
                      user?.displayName ?? 'Welcome',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 250, 229, 112),
                          fontSize: 20),
                    )
                  : Text(
                      'Welcome',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 250, 229, 112),
                          fontSize: 20),
                    ),
              accountEmail: user != null
                  ? Text(
                      user?.email ?? '',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 250, 229, 112),
                          fontSize: 16),
                    )
                  : null,
            ),
            ListTile(
              leading: Icon(
                Icons.remove_red_eye,
                color: Color.fromARGB(255, 27, 30, 37),
              ),
              title: Text(
                'Customer View',
                style: TextStyle(
                  color: Color.fromARGB(255, 27, 30, 37),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Customer()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
                color: Color.fromARGB(255, 27, 30, 37),
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                  color: Color.fromARGB(255, 27, 30, 37),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PersonDetailScreen()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.add_box,
                color: Color.fromARGB(255, 27, 30, 37),
              ),
              title: Text(
                'Add Item',
                style: TextStyle(
                  color: Color.fromARGB(255, 27, 30, 37),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Additem()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.offline_pin_rounded,
                color: Color.fromARGB(255, 27, 30, 37),
              ),
              title: Text(
                'Order List',
                style: TextStyle(
                  color: Color.fromARGB(255, 27, 30, 37),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminOrdersScreen()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Color.fromARGB(255, 27, 30, 37),
              ),
              title: Text(
                'Customer List',
                style: TextStyle(
                  color: Color.fromARGB(255, 27, 30, 37),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Person()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Color.fromARGB(255, 27, 30, 37),
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  color: Color.fromARGB(255, 27, 30, 37),
                ),
              ),
              onTap: () {
                AuthHelper.signOut(context);
              },
            ),
          ]),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 120),
              Wrap(
                spacing: 4,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Person()),
                      );
                    },
                    child: customcard(
                      subtitle: '',
                      title: 'Customer Details',
                      avtarimage: "assets/images/person.jpeg",
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminOrdersScreen()),
                      );
                    },
                    child: customcard(
                      subtitle: '',
                      title: 'Order Detail',
                      avtarimage: "assets/images/order.jpeg",
                    ),
                  ),
                  Container(
                    color: Colors.pink,
                    width: 100,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Additem()),
                      );
                    },
                    child: customcard(
                      subtitle: '',
                      title: 'Add Items',
                      avtarimage: "assets/images/add.jpeg",
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
