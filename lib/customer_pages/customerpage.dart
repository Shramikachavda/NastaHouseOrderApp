import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_order/auth_helper.dart';
import 'package:food_order/custom_widget/Card.dart';
import 'package:food_order/customer_pages/itemscreen.dart';
import 'package:food_order/customer_pages/itemscreen1.dart';
import 'package:food_order/customer_pages/order_detail.dart';
import 'package:food_order/customer_pages/placedOrder.dart';
import 'package:food_order/customer_pages/terms.dart';
import 'package:food_order/detailperson.dart';

class Customer extends StatefulWidget {
  const Customer({super.key});

  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WELCOME'),
        // centerTitle: true,

        backgroundColor: const Color.fromARGB(255, 250, 229, 112),
        //
      ),
      //
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
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
                Icons.home,
                color: Color.fromARGB(255, 27, 30, 37),
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  color: Color.fromARGB(255, 27, 30, 37),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Customer()));
                Navigator.pop(context);
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
                Icons.shopping_cart_outlined,
                color: Color.fromARGB(255, 27, 30, 37),
              ),
              title: Text(
                'Cart',
                style: TextStyle(
                  color: Color.fromARGB(255, 27, 30, 37),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Placedorder()));
                //    .then((value) =>
                // Navigate to settings screen or perform other actions
                //  Navigator.pop(context));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.info_outlined,
                color: Color.fromARGB(255, 27, 30, 37),
              ),
              title: Text(
                'Terms & ConditionsPage',
                style: TextStyle(
                  color: Color.fromARGB(255, 27, 30, 37),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Terms()));
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
          ],
        ),
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          children: [
            Container(
              height: 180,
              color: Color.fromARGB(255, 27, 30, 37),
              child: Column(
                children: [
                  SizedBox(height: 15),
                  Container(
                    child: Center(
                        child: Image.asset(
                            height: 100, "assets/images/logo.jpeg")),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Enjoy Healthy Nashta with Us !",
                    style: TextStyle(
                      color: Color.fromARGB(255, 250, 229, 112),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            //
            SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 230,
                    width: double.maxFinite,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          //
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ItemsScreen('Namkeen')),
                              );
                            },
                            child: customcard(
                                title: 'Namkeen',
                                subtitle: "",
                                avtarimage: "assets/images/namkeen.jpeg"),
                          ),

                          //
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ItemsScreen('Sweet')),
                              );
                            },
                            child: customcard(
                                title: 'Sweet',
                                subtitle: "",
                                avtarimage: "assets/images/ladu.jpeg"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //
            SizedBox(
              height: 5,
            ),
            Container(
              height: 230,
              width: double.infinity,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ItemsScreen1('Thepla')),
                  );
                },
                child: customcard(
                    title: 'Thepla',
                    subtitle: "",
                    avtarimage: "assets/images/thepla.jpeg"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
