import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../screen/pots_screen.dart';

class Homescreen extends StatefulWidget {
  
  static const route = "./homescreen";

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<String> image = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6LZPq6Pv3BUKJGx3V5JT9x9VBkWCKXmUiqg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVlFOW9WfJesDHO8jBl4URjUQajGhm8kHx9g&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVlFOW9WfJesDHO8jBl4URjUQajGhm8kHx9g&usqp=CAU",
  ];

  Widget category(BuildContext context){
    final size = MediaQuery.of(context).size;
    return  Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(onTap: (){
                Navigator.of(context).pushReplacementNamed(Potsscreen.route);
              },
                              child: Container(
                  height: size.height * 0.15,
                  width: size.width * 0.3,
                   decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                  child: Image.network(
                      "https://cdn.dnaindia.com/sites/default/files/styles/full/public/2017/08/24/603795-preethi-kitchen-appliances-082417.jpg",fit: BoxFit.contain,),
                ),
              ),
             
              InkWell(onTap: (){
                Navigator.of(context).pushReplacementNamed(Potsscreen.route);
              },
                              child: Container(
                  height: size.height * 0.15,
                  width: size.width * 0.3,
                  decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                  child: Image.network(
                      "https://cdn.dnaindia.com/sites/default/files/styles/full/public/2017/08/24/603795-preethi-kitchen-appliances-082417.jpg",fit: BoxFit.contain,),
                ),
              ),
              InkWell(onTap: (){
                Navigator.of(context).pushReplacementNamed(Potsscreen.route);
              },
                              child: Container(
                  height: size.height * 0.15,
                  width: size.width * 0.3,
                   decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                  child: Image.network(
                      "https://cdn.dnaindia.com/sites/default/files/styles/full/public/2017/08/24/603795-preethi-kitchen-appliances-082417.jpg",fit: BoxFit.contain,),
                ),
              )
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Kitchen Appliances"),
      ),
      body: Column(
        children: [
          CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: false,
                aspectRatio: 2.0,
              ),
              items: image.map((card) {
                return Builder(builder: (BuildContext context) {
                  return Container(
                      height: size.height * 0.30,
                      width: size.width,
                      child: Card(
                          color: Colors.blueAccent,
                          child: Image.network(
                            card,
                            fit: BoxFit.cover,
                          )));
                });
              }).toList()),
          SizedBox(height: 15),
         category(context),
         SizedBox(height: 15),
         category(context),
         SizedBox(height: 15,),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             Container(height: size.height*0.2,width:size.width*0.4,child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT31AptatDLwWo7JNK-mhsz5dRNjDgPP7YfQg&usqp=CAU",fit: BoxFit.cover,),),
              Container(height: size.height*0.2,width:size.width*0.4,child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRE1xOAv8w2vMtqngZdy4gBlhYOqjH_1re7_g&usqp=CAU",fit: BoxFit.cover,),)
           ],
         )

        ],
      ),
    );
  }
}
