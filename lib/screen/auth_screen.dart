import 'package:flutter/material.dart';
import '../screen/home_screen.dart';

import '../provider/auth.dart';



class Authscreen extends StatefulWidget {
  static const route = "./Authscreen";
  @override
  _AuthscreenState createState() => _AuthscreenState();
}

class _AuthscreenState extends State<Authscreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Auth auth = Auth();
    return Scaffold(
      body: 
          
          Center(
            child: Container(
              height: size.height * 0.07,
              child: RaisedButton(
                onPressed: () {
                  auth.signin().then(
                    (value) {
                      if (value == null) {
                        Navigator.of(context)
                            .pushReplacementNamed(Authscreen.route);
                       
                      } else {
                         Navigator.of(context)
                            .pushReplacementNamed(Homescreen.route);
                      }
                    },
                  );
                },
                color: Colors.redAccent,
                child: Container(
                  width: size.width * 0.7,
                  color: Colors.redAccent,
                  child: Row(
                    children: [
                      Container(
                        height: size.height * 0.05,
                        child: Image.asset(
                          "assets/google.png",
                        ),
                      ),
                   SizedBox(width: 10),
                      Text(
                        "Sign In With Google",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        
      
    );
  }
}
