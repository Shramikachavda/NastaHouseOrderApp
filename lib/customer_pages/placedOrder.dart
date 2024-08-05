import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Placedorder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 229, 112),
        title: Text('Your Orders'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection('orders')
            // .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> ordersSnapshot) {
          if (ordersSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (ordersSnapshot.hasError) {
            return Center(child: Text('An error occurred!'));
          }
          if (ordersSnapshot.data == null ||
              ordersSnapshot.data!.docs.isEmpty) {
            return Center(child: Text('No orders placed yet.'));
          }

          final orders = ordersSnapshot.data!.docs;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              var order = orders[index];
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  elevation: 8,
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Name: ${order['Name']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Quantity: ${order['Quantity']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Price: ₹${order['Price']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Total Price: ₹${order['totalPrice']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Status: ${order['Status'] ?? 'NotPrepare'}',
                          style: TextStyle(
                            fontSize: 16,
                            color: order['Status'] == 'Prepared'
                                ? Colors.green[300]
                                : Colors.red[300],
                          ),
                        ),
                        Text(
                          'Order Done: ${order['Take'] ?? 'Not Done'}',
                          style: TextStyle(
                            fontSize: 16,
                            color: order['Take'] == 'Done'
                                ? Colors.green[300]
                                : Colors.red[300],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
