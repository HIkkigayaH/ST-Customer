import 'package:flutter/material.dart';
import '../provider/auth.dart';
import './home_screen.dart';
import './auth_screen.dart';

class Appdrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Auth auth =Auth();
    return Drawer(
    child: Column(
      children: [
        SizedBox(height:40),
        Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              child: FlatButton.icon(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(Homescreen.route);
                },
                icon: Icon(
                  Icons.home,
                  color: Colors.green,
                ),
                label: Text(
                  "Home Screen",
                  style: TextStyle(color: Colors.green),
                ),
              )),
               Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            child: FlatButton.icon(
              onPressed: () {
                auth.signOut();
                Navigator.of(context).pushReplacementNamed(Authscreen.route);
              },
              icon: Icon(
                Icons.logout,
                color: Colors.green,
              ),
              label: Text(
                "Sign Out",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ),
      ],
    ),
    );
  }
}