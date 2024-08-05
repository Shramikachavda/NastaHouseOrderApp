import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_order/customer_pages/customerpage.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String status = 'NotPrepare';
    String takeaway = 'Not Done';

    Future<void> _deleteCartItem(String id) async {
      print(id);
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('cart')
          .doc(id)
          .delete();
    }

    Future<void> _placeOrder(List<DocumentSnapshot> cartItems) async {
      final CollectionReference cartRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('cart');

      final CollectionReference ordersRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('orders');

      try {
        for (DocumentSnapshot cartItem in cartItems) {
          // Extract required information
          Map<String, dynamic> orderData = {
            'Name': cartItem['Name'],
            'Quantity': cartItem['Quantity'],
            'Price': cartItem['price'],
            'totalPrice': cartItem['Total'],
            'createdAt': Timestamp.now(),
            'Status': status,
            'Take': takeaway
          };

          await ordersRef.add(orderData); // Add item to orders collection
          await cartRef
              .doc(cartItem.id)
              .delete(); // Delete item from cart collection
        }
      } catch (e) {
        print('Failed to place order: $e');
      }
    }

    Future<void> _confirmPlaceOrder(
        BuildContext context, List<DocumentSnapshot> cartItems) async {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get();

        String userRole = userDoc['role'];
        if (userRole != 'customer') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: const Color.fromARGB(255, 250, 229, 112),
              content: Text(
                'Only customers can place orders.',
                style: TextStyle(
                  color: Color.fromARGB(255, 27, 30, 37),
                  fontSize: 16,
                ),
              ),
            ),
          );
          return;
        }
        _placeOrder(cartItems);
      } catch (e) {
        print('Error fetching user role or placing order: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color.fromARGB(255, 250, 229, 112),
            content: Text(
              'Failed to place order. Please try again later.',
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 27, 30, 37),
              ),
            ),
          ),
        );
      }
    }

    Future<void> _handlePlaceOrder(
        BuildContext scaffoldContext, List<DocumentSnapshot> cartItems) async {
      // Trigger confirmation dialog
      await showDialog(
        context: scaffoldContext,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirm Order"),
            content: Text("Are you sure you want to place this order?"),
            actions: <Widget>[
              TextButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("Place Order"),
                onPressed: () {
                  Navigator.of(context).pop();
                  // Call _confirmPlaceOrder to handle order placement
                  _confirmPlaceOrder(scaffoldContext, cartItems);
                },
              ),
            ],
          );
        },
      ).then((_) async {
        // Check if order was successfully placed by customer
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get();
        String userRole = userDoc['role'];
        if (userRole == 'customer') {
          // Navigate to home screen after placing order
          Navigator.pushReplacement(
            scaffoldContext,
            MaterialPageRoute(builder: (context) => Customer()),
          );
          // Show success message
          ScaffoldMessenger.of(scaffoldContext).showSnackBar(
            SnackBar(
              backgroundColor: const Color.fromARGB(255, 250, 229, 112),
              content: Text(
                'Your Order Placed Successfully',
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 27, 30, 37),
                ),
              ),
            ),
          );
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 229, 112),
        title: Text('Your Cart'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection('cart')
              .snapshots(),
          builder: (ctx, AsyncSnapshot<QuerySnapshot> cartSnapshot) {
            if (cartSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (cartSnapshot.hasError) {
              return Center(child: Text('An error occurred!'));
            }
            if (cartSnapshot.data == null || cartSnapshot.data!.docs.isEmpty) {
              return Center(child: Text('No items in your cart.'));
            }

            final cartItems = cartSnapshot.data!.docs;

            double totalPrice = _calculateTotalPrice(cartItems);

            return Column(children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    var cartData = cartItems[index];
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        elevation: 8,
                        child: Container(
                          height: 130,
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 90,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      cartData['Quantity'].toString(),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(cartData['Image']),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        _deleteCartItem(cartData
                                            .id); // Call function to delete item
                                      },
                                    ),
                                    Text(
                                      cartData['Name'],
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '\₹${cartData['price'].toString()} × ${cartData['Quantity']}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w200,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          '\₹${cartData['Total'].toString()}',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      ' \₹${totalPrice.toStringAsFixed(2)}', // Assuming totalPrice is a double
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        color: Colors.black12,
                      ),
                    ],
                    color: Color.fromARGB(255, 27, 30, 37),
                  ),
                  child: TextButton(
                    child: Text(
                      'Place Order',
                      style: TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 250, 229, 112),
                      ),
                    ),
                    onPressed: () async {
                      await _handlePlaceOrder(context, cartItems);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  '* Please remember to pick up your takeaway orders from Our home.',
                  style:
                      TextStyle(fontWeight: FontWeight.w100, color: Colors.red),
                ),
              ),
            ]);
          }),
    );
  }

  double _calculateTotalPrice(List<dynamic> cartItems) {
    double totalPrice = 0.0;
    for (var item in cartItems) {
      if (item['Total'] != null) {
        totalPrice += double.tryParse(item['Total'].toString()) ?? 0.0;
      }
    }
    return totalPrice;
  }
}
