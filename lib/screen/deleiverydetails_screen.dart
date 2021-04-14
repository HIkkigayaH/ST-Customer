import 'package:flutter/material.dart';
import '../screen/home_screen.dart';
import 'package:provider/provider.dart';

import '../provider/order.dart';


class Deleiverydetailsscreen extends StatefulWidget {
  static const route = "./Deleiverydetailsscreen";
  @override
  _DeleiverydetailsscreenState createState() => _DeleiverydetailsscreenState();
}

class _DeleiverydetailsscreenState extends State<Deleiverydetailsscreen> {
  final form = GlobalKey<FormState>();
  TextEditingController name;
  TextEditingController phoneno;
  TextEditingController address;
  TextEditingController district;
  TextEditingController pin;
  final namenode = FocusNode();
  final phonenode = FocusNode();
  final addressnode = FocusNode();
  final districtnode = FocusNode();
  final pinnode = FocusNode();


  var details = Address(
    name: "",
    address: "",
    district: "",
    phoneno: null,
    pin: null,
  );

  var isloading = false;

  Future<void> finaldetails(BuildContext ctx) async {
    final isvalid = form.currentState.validate();
    if (!isvalid) {
      return;
    } else {
      form.currentState.save();
      setState(() {
        isloading = true;
      });
      try {
        await Provider.of<Orders>(context, listen: false).confirm(details);
      } catch (error) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('error occured'),
                  content: Text(error),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('okay')),
                  ],
                ));
      }
    }
    setState(() {
      isloading = false;
    });
    showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          title: Text('Order Confirmation'),
          content: Text('Your Order Has Been Successful'),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(context).popAndPushNamed(Homescreen.route);
                },
                child: Text('ok'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Deleivery Details"),
        backgroundColor: Colors.red,
      ),
      body: isloading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Form(
                key: form,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(17),
                        width: size.width * 0.9,
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red)),
                        child: TextFormField(
                          controller: name,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(phonenode);
                          },
                          focusNode:namenode ,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Your Name"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "enter the name";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            details = Address(
                                address: details.address,
                                district: details.district,
                                name: value,
                                phoneno: details.phoneno,
                                pin: details.pin);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(17),
                        width: size.width * 0.9,
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red)),
                        child: TextFormField(
                          controller: phoneno,
                          focusNode: phonenode,
                          onFieldSubmitted: (_){
                            FocusScope.of(context).requestFocus(addressnode);
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Your Phone Number"),
                          validator: (value) {
                            if (value.length != 10) {
                              return "enter the phone number";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            details = Address(
                                address: details.address,
                                district: details.district,
                                name: details.name,
                                phoneno: int.parse(value),
                                pin: details.pin);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.all(17),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          width: size.width * 0.6,
                          height: size.height * 0.2,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.red)),
                          child: TextFormField(
                            controller: address,
                            focusNode: addressnode,
                            maxLines: 7,
                             onFieldSubmitted: (_){
                            FocusScope.of(context).requestFocus(pinnode);
                          },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter The Address"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'enter the address';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              details = Address(
                                  address: value,
                                  district: details.district,
                                  name: details.name,
                                  phoneno: details.phoneno,
                                  pin: details.pin);
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(17),
                          child: Container(
                            width: size.width * 0.35,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red)),
                            child: TextFormField(
                              controller: pin,
                              keyboardType: TextInputType.number,
                              focusNode: pinnode,
                               onFieldSubmitted: (_){
                            FocusScope.of(context).requestFocus(districtnode);
                          },
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: "Pin No"),
                              validator: (value) {
                                if (value.length != 6) {
                                  return "enter the Pin No";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                details = Address(
                                  address: details.address,
                                  district: details.district,
                                  name: details.name,
                                  phoneno: details.phoneno,
                                  pin: int.parse(value),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(17),
                          child: Container(
                            width: size.width * 0.35,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red)),
                            child: TextFormField(
                              controller: district,
                              focusNode: districtnode,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "District"),
                                   onFieldSubmitted: (_){
                            FocusScope.of(context).unfocus();
                          },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "enter the district";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                details = Address(
                                    address: details.address,
                                    district: value,
                                    name: details.name,
                                    phoneno: details.phoneno,
                                    pin: details.pin);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 17),
                    RaisedButton(
                      onPressed: () {
                        finaldetails(context);
                      },
                      child: Text(
                        "Confirm your Order",
                      ),
                      color: Colors.green,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
