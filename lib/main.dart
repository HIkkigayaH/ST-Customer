import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mainapp/provider/order.dart';
import 'package:mainapp/screen/product_details.dart';
import 'package:provider/provider.dart';
import './provider/auth.dart';
import './screen/auth_screen.dart';
import './screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import './screen/searchview_screen.dart';
import './screen/pots_screen.dart';
import './screen/deleiverydetails_screen.dart';
import './screen/ordering_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
 
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Auth auth = Auth();
  bool isLoggedin = true;

  @override
  void initState() {
    auth.autoLogin().then(
      (value) {
        print(value);
        if (value == 'null') {
          setState(
            () {
              isLoggedin = false;
            },
          );
        } else {
          setState(
            () {
              isLoggedin = true;
            },
          );
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MultiProvider(providers: [
       ChangeNotifierProvider(
          create: (context) =>  Auth(),
        ),
        ChangeNotifierProvider(
          create: (context) =>  Orders(),
        ),
        
       
    ],
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.red),
       home: isLoggedin? Homescreen() : Authscreen(),
       routes: {
         Authscreen.route:(ctx)=>Authscreen(),
         Homescreen.route:(ctx)=>Homescreen(),
         Searchviewscreen.route: (ctx) => Searchviewscreen(),
          Potsscreen.route: (ctx) => Potsscreen(),
          Orderingscreen.route: (ctx) => Orderingscreen(),
          Deleiverydetailsscreen.route: (ctx) => Deleiverydetailsscreen(),
          ProductDetails.route:(ctx)=>ProductDetails(),
       },
      ),
    );
  }
}
