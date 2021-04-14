import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../looks/product_look.dart';



class Productoverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    final sizes = MediaQuery.of(context).size;
   
  
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance
              .collection("products")
              .orderBy("price", descending: true)
              .snapshots(),
          
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final products = snap.data.documents;
        if (products.length <= 0) {
          return Scaffold(
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset(
                    "assets/NoData.png",
                  ),
                  height: sizes.height * 0.25,
                ),
                Center(
                  child: Text(
                    "No Products Availabel",
                    style: TextStyle(color: Colors.green, fontSize: 23),
                  ),
                )
              ],
            )),
          );
        }
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemCount: products.length,
          itemBuilder: (ctx, index) {
            return Productlook(
                key: key,
                title: products[index]["title"],
                imageurl: products[index]['imageurl'][0],
                price: products[index]['price'],
                id: products[index].documentID,
                subtitle: products[index]["subtitle"]);
          },
        );
      },
    );
  }
}
