import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Orders'),
        backgroundColor: const Color.fromARGB(255, 250, 229, 112),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> usersSnapshot) {
          if (usersSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (usersSnapshot.hasError) {
            return Center(child: Text('An error occurred!'));
          }
          if (usersSnapshot.data == null || usersSnapshot.data!.docs.isEmpty) {
            return Center(child: Text('No users found.'));
          }

          // Fetching all users
          final users = usersSnapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (ctx, index) {
              final userDoc = users[index];
              final userData = userDoc.data() as Map<String, dynamic>;

              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(userDoc.id)
                    .collection('orders')
                    .snapshots(),
                builder: (ctx, AsyncSnapshot<QuerySnapshot> ordersSnapshot) {
                  if (ordersSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (ordersSnapshot.hasError) {
                    return Text('Error fetching orders');
                  }

                  // Filter out users without orders
                  if (ordersSnapshot.data == null ||
                      ordersSnapshot.data!.docs.isEmpty) {
                    return SizedBox.shrink(); // Skip rendering this user
                  }

                  // Fetching orders for the current user
                  final orders = ordersSnapshot.data!.docs;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Card(
                          elevation: 2,
                          shadowColor: const Color.fromARGB(255, 250, 229, 112),
                          child: ListTile(
                            title: Text('Name: ${userData['name']}'),
                            subtitle: Text('Number: +91 ${userData['phone']}'),
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: orders.length,
                        itemBuilder: (ctx, index) {
                          final orderDoc = orders[index];
                          final orderData =
                              orderDoc.data() as Map<String, dynamic>;

                          return Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            elevation: 4,
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Item Name: ${orderData['Name']}'),
                                  Text('Price: ₹${orderData['Price']}'),
                                  Text('Quantity: ${orderData['Quantity']} gm'),
                                  Text(
                                      'Total Price: ₹${orderData['totalPrice']}'),
                                  SizedBox(height: 3),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Status: ${orderData['Status'] ?? 'NotPrepared'}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              orderData['Status'] == 'Prepared'
                                                  ? Colors.green[300]
                                                  : Colors.red[300],
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                WidgetStatePropertyAll(2),
                                            surfaceTintColor:
                                                WidgetStatePropertyAll(
                                              Color.fromARGB(255, 27, 30, 37),
                                            )),
                                        onPressed: () {
                                          // Update order status logic here
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(userDoc.id)
                                              .collection('orders')
                                              .doc(orderDoc.id)
                                              .update({
                                            'Status': 'Prepared'
                                          }).then((value) {
                                            ScaffoldMessenger.of(ctx)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 250, 229, 112),
                                                content: Text(
                                                  'Order status updated successfully',
                                                  style: TextStyle(
                                                    color: const Color.fromARGB(
                                                        255, 27, 30, 37),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).catchError((error) {
                                            ScaffoldMessenger.of(ctx)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 250, 229, 112),
                                                content: Text(
                                                  'Failed to update order status: $error',
                                                  style: TextStyle(
                                                    color: const Color.fromARGB(
                                                        255, 27, 30, 37),
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                        },
                                        child: Text(
                                          'Mark as Prepared',
                                          style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 27, 30, 37),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Order Done: ${orderData['Take'] ?? 'Not Done'}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: orderData['Take'] == 'Done'
                                              ? Colors.green[300]
                                              : Colors.red[300],
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                WidgetStatePropertyAll(2),
                                            surfaceTintColor:
                                                WidgetStatePropertyAll(
                                              Color.fromARGB(255, 27, 30, 37),
                                            )),
                                        onPressed: () {
                                          // Update order status logic here
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(userDoc.id)
                                              .collection('orders')
                                              .doc(orderDoc.id)
                                              .update({'Take': 'Done'}).then(
                                                  (value) {
                                            ScaffoldMessenger.of(ctx)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 250, 229, 112),
                                                content: Text(
                                                  'Order Done Completely',
                                                  style: TextStyle(
                                                    color: const Color.fromARGB(
                                                        255, 27, 30, 37),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).catchError((error) {
                                            ScaffoldMessenger.of(ctx)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 250, 229, 112),
                                                content: Text(
                                                  'Failed to update Order Done Status : $error',
                                                  style: TextStyle(
                                                    color: const Color.fromARGB(
                                                        255, 27, 30, 37),
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                        },
                                        child: Text(
                                          'Order Done',
                                          style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 27, 30, 37),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
