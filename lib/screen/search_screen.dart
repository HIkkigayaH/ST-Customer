import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/product_overview.dart';

import '../screen/searchview_screen.dart';

class Searchscreen extends StatelessWidget {
  final String search;
  Searchscreen(this.search);
  @override
  Widget build(BuildContext context) {
    return search == null || search.isEmpty
        ? Productoverview()
        : StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("products")
                .where("caseSearch", arrayContains: search)
                .snapshots(),
            builder: (ctx, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final product = snap.data.documents;
              final List<String> data = [];
              for (int j = 0; j < product.length; j++) {
                data.add(product[j]['title']);
              }
              print(data);
              final List<String> screen = [];
              for (int i = 0; i < data.length; i++) {
                if (i == 0) {
                  screen.add(data[i]);
                } else {
                  if (data[i] == data[i - 1]) {
                  } else {
                    screen.add(data[i]);
                  }
                }
              }
              return ListView.builder(
                itemBuilder: (ctx, index) {
                  return ListTile(
                    title: Center(
                      child: Text(
                        screen[index],
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          Searchviewscreen.route,
                          arguments: product[index]["title"]);
                    },
                  );
                },
                itemCount: screen.length,
              );
            },
          );
  }
}
