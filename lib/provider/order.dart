import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Order {
  final String id;
  final String title;
  final String imageurl;
  final int price;
  final int quantity;

  Order({
    this.id,
    this.title,
    this.price,
    this.imageurl,
    this.quantity,
  });
}

class Address {
  final String name;
  final int phoneno;
  final String address;
  final String district;
  final int pin;
  Address({this.address, this.district, this.name, this.phoneno, this.pin});
}

class TransgenderForm {
  final String name;
  final int phoneno;
  final DateTime dob;
  final int age;
  final String schoolname;
  final String collegename;
  final String qualification;
  final String address;
  final String district;
  final int pin;
  TransgenderForm({
    this.address,
    this.age,
    this.collegename,
    this.district,
    this.dob,
    this.name,
    this.phoneno,
    this.pin,
    this.qualification,
    this.schoolname,
  });
}

class Orders with ChangeNotifier {
  List<Order> orderpreview = [];

  List<Order> get orderpreviews {
    return orderpreview;
  }

  Future<void> addtoorderpreview({
    String id,
    String imageurl,
    int price,
    int quantity,
    String title,
  }) async {
    final index = orderpreview.indexWhere((element) => element.id == id);

    int data;
    if (index < 0) {
      orderpreview.add(
        Order(
          title: title,
          quantity: quantity,
          price: price,
          imageurl: imageurl,
          id: id,
        ),
      );
    } else {
      data = orderpreview[index].quantity;
      orderpreview.removeAt(index);
      orderpreview.add(Order(
        title: title,
        quantity: data + quantity,
        price: price,
        imageurl: imageurl,
        id: id,
      ));
    }
    notifyListeners();
    
  }

  void remove(String id) {
    orderpreview.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void cancel() {
    int length = orderpreview.length;
    orderpreview.removeRange(0, length);
  }

  double get total {
    var total = 0.0;
    orderpreview.forEach((element) {
      total += (element.price * element.quantity);
    });
    return total;
  }

  Address faddress = Address();
  Address get finaladdress {
    return faddress;
  }

  Future<void> confirm(
    Address address,
  ) async {
    await FirebaseFirestore.instance.collection("orders").doc().set({
      'address': {
        'name': address.name,
        'phone_no': address.phoneno,
        'address': address.address,
        'district': address.district,
        'pin_no': address.pin,
      },
      'order_list': orderpreview.map((e) {
        return {
          'title': e.title,
          'price': e.price,
          'imageurl': e.imageurl,
          'id': e.id,
          'quantity': e.quantity
        };
      }).toList()
    });
    int length = orderpreview.length;
    orderpreview.removeRange(0, length);
  }

  Future<void> formdetails(
      TransgenderForm transgenderForm, DateTime selecteddate) async {
    await FirebaseFirestore.instance.collection("transgender").doc().set({
      'name': transgenderForm.name,
      'phone_no': transgenderForm.phoneno,
      'DOB': Timestamp.fromDate(selecteddate),
      'address': transgenderForm.address,
      'pin_code': transgenderForm.pin,
      'school_name': transgenderForm.schoolname,
      'college_name': transgenderForm.collegename,
      'qualification': transgenderForm.qualification,
      'district': transgenderForm.district,
      'age': transgenderForm.age
    });
  }
}
