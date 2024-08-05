import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
        backgroundColor: Color.fromARGB(255, 250, 229, 112),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text(
              'Order Processing Time:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                'Orders typically require 2 to 3 days for preparation. '
                'In case of any delays beyond this timeframe, we will promptly inform you.'),
          ),
          SizedBox(
            height: 5,
          ),
          ListTile(
            title: Text(
              'Order Collection:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                'Customers are required to collect their orders from their specified address. '
                'If your home is near our location, we may offer delivery with an additional charge.'),
          ),
          SizedBox(
            height: 5,
          ),
          ListTile(
            title: Text(
              'Delivery Charges:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                'Additional delivery charges may apply for orders delivered to locations beyond our specified area. '
                'Please contact us for details.'),
          ),
          SizedBox(
            height: 5,
          ),
          ListTile(
            title: Text(
              'Contact Information:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                'Address: ABC Apartments, Near City Center Mall, XY Road, Ahmedabad - 3800XX'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text('Contact Number: +91 1234566789'),
          )
        ],
      ),
    );
  }
}
