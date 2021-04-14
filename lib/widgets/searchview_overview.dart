import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../looks/searchview_look.dart';

class Searchviewoverview extends StatelessWidget {
  final String search;
  Searchviewoverview(this.search);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("products")
          .where("caseSearch", arrayContainsAny: [
        search.toUpperCase(),
      ]).snapshots(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final products = snap.data.documents;
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 6,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemCount: products.length,
          itemBuilder: (ctx, index) {
            return Searchviewlook(
                title: products[index]["title"],
                imageurl: products[index]['imageurl'][0],
                price: products[index]["price"],
                id: products[index].documentID,
                subtitle: products[index]["subtitle"]);
          },
        );
      },
    );
  }
}
