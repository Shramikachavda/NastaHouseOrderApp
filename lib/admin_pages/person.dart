import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Person extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 250, 229, 112),
          title: Text('Customer Details'),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (ctx, AsyncSnapshot<QuerySnapshot> customerSnapshot) {
              if (customerSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (customerSnapshot.hasError) {
                return Center(child: Text('An error occurred!'));
              }
              if (customerSnapshot.data == null ||
                  customerSnapshot.data!.docs.isEmpty) {
                return Center(child: Text('No Customer is Register'));
              }

              final customer = customerSnapshot.data!.docs;

              return ListView.builder(
                itemCount: customer.length,
                itemBuilder: (context, index) {
                  var cus = customer[index];
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
                                  'Customer Details',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Name: ${cus['name']}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  'Email Id: ${cus['email']}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  'Phone Number: +91 ${cus['phone']}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  'Role: ${cus['role']}',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.red),
                                ),
                              ],
                            ))),
                  );
                },
              );
            }));
  }
}
