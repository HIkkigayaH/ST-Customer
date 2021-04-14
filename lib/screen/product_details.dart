import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductDetails extends StatefulWidget {
  static const route = "./productdetails";
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String id;
  bool isinit = true;
  List<String> image = [];
  String description = '';
  String title='';
  @override
  void didChangeDependencies() async {
    if (isinit == true) {
      final ids = ModalRoute.of(context).settings.arguments as String;
      id = ids;

      final images =
          await FirebaseFirestore.instance.collection('products').doc(id).get();
      final imaged = images.data();
      final nakkul = imaged['imageurl'];

      for (int i = 0; i < nakkul.length; i++) {
        setState(() {
          image.add(nakkul[i]);
          description = imaged['description'];
          title=imaged['title'];
        });
        // image.add(nakkul[i]);
      }

      isinit = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Informarion",
        ),
        backgroundColor: Colors.red,
      ),
      body: Column(children:[
        SizedBox(height:20),
        Center(child: Container(width:size.width*0.9 ,height:size.height*0.05,child: Text(title,style: TextStyle(fontSize: 16,color: Colors.red),),)),
         CarouselSlider(
                          options: CarouselOptions(
                            height: 200.0,
                            autoPlay: false,
                             autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration: Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            // pauseAutoPlayOnTouch: Duration(seconds: 10),
                            aspectRatio: 2.0,
                           
                          ),
                          //items: <Widget>[Image.network(datas[0]['imageurl'])],

                          items:image.map((card) {
                            return Builder(builder: (BuildContext context) {
                              return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.30,
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                      color: Colors.blueAccent,
                                      child: Image.network(
                                        card,
                                        fit: BoxFit.cover,
                                      )));
                            });
                          }).toList()),
                          SizedBox(height:30),
                          Column(
                            children: [
                              Container(child:Text("Description",style: TextStyle(fontSize: 20,color: Colors.red),)),
                              SizedBox(height:20),
                              Container(child:Text(description,style: TextStyle(fontSize: 18,),),width: size.width*0.8,),
                            ],
                          )
      ]),
    );
  }
}
