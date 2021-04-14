import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/order.dart';

class Orderinglook extends StatelessWidget {
  final String imageurl;
  final String id;
  final int price;
  final String title;
  final int quantity;

  Orderinglook({
    this.id,
    this.imageurl,
    this.price,
    this.quantity,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Orders>(context);

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(19),
          child: Stack(
            children: <Widget>[
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      child: Image.network(
                        imageurl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Flexible(child: Text(title)),
                    Flexible(
                        child: Text(
                            '${quantity.toString()} * ₹${price.toString()}')),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                ),
              ),
              Positioned(
                bottom: 40,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    order.remove(id);
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
