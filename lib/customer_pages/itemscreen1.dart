import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_order/customer_pages/detailthepla.dart';

class ItemsScreen1 extends StatelessWidget {
  final String category;

  ItemsScreen1(this.category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 229, 112),
        title: Text('$category Items'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection(category).snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No items found.'));
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => detailPagethepla(
                                  image: data['Image'],
                                  name: data["Name"],
                                  price: data['Price'],
                                )));
                  },
                  child: Container(
                      height: 180,
                      width: double.infinity,
                      child: Card(
                        elevation: 8,
                        child: SingleChildScrollView(
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Container(
                                height: 160,
                                width: 150,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color.fromARGB(255, 27, 30, 37),
                                        width: 1.5),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(data['Image']))),
                              ),
                              SizedBox(width: 10),
                              Container(
                                height: 120,
                                width: 180,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      data['Name'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Price:${data['Price']} ₹',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
