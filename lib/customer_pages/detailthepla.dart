import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_order/auth_helper.dart';
import 'package:flutter/material.dart';

class detailPagethepla extends StatefulWidget {
  final String price, image, name;
  detailPagethepla({
    super.key,
    required this.image,
    required this.name,
    required this.price,
  });

  @override
  State<detailPagethepla> createState() => _detailPagetheplaState();
}

class _detailPagetheplaState extends State<detailPagethepla> {
  int a = 1, total = 0;

  int b = 1;
  String? uid;
  @override
  void initState() {
    super.initState();
    total = int.parse(widget.price);
  }

  UserId() {
    User? user = FirebaseAuth.instance.currentUser;
    return user!.uid;
  }

  Future addtoCart() async {
    uid = UserId();
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cart')
        .add({
          'Name': widget.name,
          "Quantity": a.toString(),
          "Total": total.toString(),
          "Image": widget.image,
          "price": widget.price
        })
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color.fromARGB(255, 250, 229, 112),
            content: Text(
              'Item Added to Cart',
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 27, 30, 37),
              ),
            ))))
        .catchError((error) =>
            alertBox.CustomAlertBox(context, 'Failed to Add' + error));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 250, 229, 112),
      ),
      body: Stack(
        children: [
          Container(
            color: Color.fromARGB(20, 27, 30, 37),
            height: double.maxFinite,
            child: Container(
              margin: EdgeInsets.only(top: 480, left: 30, right: 30),
              width: double.infinity,
              height: 300,
              child: Column(
                children: [
                  Text(
                    'Select Quantity per piece: ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                  //
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: () {
                          if (a > 1) {
                            a = a - b;
                            total = total - int.parse(widget.price);
                          }
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.remove_circle_outlined,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      a.toString(),
                      style: TextStyle(
                          //   color: Color.fromARGB(255, 250, 229, 112),
                          ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: () {
                          a = a + b;
                          total = total + int.parse(widget.price);
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.add_box,
                        ),
                      ),
                    ),
                  ]),
                  //
                  Spacer(),
                  Container(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      " Total Price",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      ' ' + total.toString() + '\₹',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 155,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(blurRadius: 20, color: Colors.black12)
                            ],
                            color: Color.fromARGB(255, 27, 30, 37),
                          ),
                          child: Center(
                            child: TextButton(
                                onPressed: () async {
                                  print('done');
                                  addtoCart();
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Add to Cart',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color:
                                            Color.fromARGB(255, 250, 229, 112),
                                      ),
                                    ),
                                    Icon(
                                      Icons.shopping_cart,
                                      color: Color.fromARGB(255, 250, 229, 112),
                                    )
                                  ],
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 70,
            ),
            height: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(top: 30, bottom: 30, left: 30, right: 30),
              height: 350,
              width: 350,
              decoration: BoxDecoration(
                // color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                border: Border.all(
                    color: Color.fromARGB(255, 250, 229, 112), width: 1.5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
                child: Image.network(
                  widget.image,
                  width: MediaQuery.of(context).size.width / 1,
                  height: MediaQuery.of(context).size.height / 2,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Container(
            color: Color.fromARGB(0, 27, 30, 37),
            height: 70,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ]),
          )
        ],
      ),
      //
    );
  }
}
