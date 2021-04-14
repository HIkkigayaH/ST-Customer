import 'package:flutter/material.dart';
import 'package:mainapp/screen/product_details.dart';
import 'package:provider/provider.dart';

import '../provider/order.dart';

import '../screen/ordering_screen.dart';

class Productlook extends StatefulWidget {
  final String imageurl;
  final String title;
  final int price;
  final String id;
  final String subtitle;

  Productlook(
      {Key key, this.imageurl, this.price, this.title, this.id, this.subtitle})
      : super(key: key);

  @override
  _ProductlookState createState() => _ProductlookState();
}

class _ProductlookState extends State<Productlook> {
  int quantity = 1;

  Future<void> buy(BuildContext ctx, String id) async {
    if (quantity == 0 || quantity.toString().isEmpty) {
      return showDialog(
        context: ctx,
        builder: (context) {
          return AlertDialog(
            title: Text('error'),
            content: Text('enter the quantity'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('ok'))
            ],
          );
        },
      );
    } else {
      return showDialog(
        context: ctx,
        builder: (context) {
          return AlertDialog(
            title: Text('order'),
            content: Text('Do you want to continue shopping ?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('yes'),
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(Orderingscreen.route);
                  },
                  child: Text('no'))
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final order = Provider.of<Orders>(context);
    return InkWell(
      onTap: (){Navigator.of(context).pushReplacementNamed(ProductDetails.route,arguments: widget.id);},
          child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
          child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: Center(
              child: Text(
            widget.title,
            style: TextStyle(color: Colors.red, fontSize: 16),
          )),
        ),
        Container(
          height: size.height * 0.2,
          child: Image.network(widget.imageurl),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text(
              "₹" + widget.price.toString(),
              style: TextStyle(fontSize: 22),
            ),
          ),
        ),
        Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 40, right: 40),
                width: double.infinity,
                child: Text(
                  "qty",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.orange, fontSize: 18),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.red)),
                  key: widget.key,
                  width: 110,
                  height: 30,
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            icon: Icon(
                              Icons.horizontal_rule,
                              size: 10,
                            ),
                            onPressed: () {
                              if (quantity == 0) {
                              } else {
                                setState(() {
                                  quantity -= 1;
                                });
                              }
                            }),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          quantity.toString(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: Icon(
                            Icons.add,
                            size: 11,
                          ),
                          onPressed: () {
                            setState(
                              () {
                                quantity += 1;
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        RaisedButton(
          color: Colors.green,
          onPressed: () {
            if (quantity.toString().isEmpty || quantity == 0) {
              buy(context, widget.id);
            } else {
              buy(context, widget.id);
              order.addtoorderpreview(
                  id: widget.id,
                  title: widget.title,
                  imageurl: widget.imageurl,
                  price: widget.price,
                  quantity: quantity);
            }
          },
          child: Container(
            child: Text("Buy Now"),
          ),
        )
      ],
          ),
        ),
    );
  }
}
