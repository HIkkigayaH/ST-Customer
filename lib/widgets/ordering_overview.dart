import 'package:flutter/material.dart';
import '../screen/home_screen.dart';
import 'package:provider/provider.dart';

import '../screen/deleiverydetails_screen.dart';

import '../provider/order.dart';

import '../looks/ordering_look.dart';


class Orderingoverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Orders>(context);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Container(
            height: size.height * 0.5,
            child: ListView.builder(
              itemCount: order.orderpreview.length,
              itemBuilder: (ctx, index) {
                //   List<Map<String,String>> items=[{'name':}];
                return Orderinglook(
                  title: order.orderpreview[index].title,
                  imageurl: order.orderpreview[index].imageurl,
                  id: order.orderpreview[index].id,
                  price: order.orderpreview[index].price,
                  quantity: order.orderpreview[index].quantity,
                );
              },
            ),
          ),
          Container(
            child: Text(
              'Total amount = ₹ ${order.total.toString()}',
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 25),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Deleiverydetailsscreen.route);
            },
            child: Text(
              'Proceed Order',
              style: TextStyle(fontSize: 20),
            ),
            color: Colors.green,
          ),
          SizedBox(
            height: 15,
          ),
          RaisedButton(
            onPressed: () {
              order.cancel();
              Navigator.of(context).pushReplacementNamed(Homescreen.route);
            },
            child: Text(
              'Cancel Order',
              style: TextStyle(fontSize: 20),
            ),
            color: Colors.red,
          )
        ],
      ),
    );
  }
}
