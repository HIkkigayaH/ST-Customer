import 'package:flutter/material.dart';
import '../screen/app_drawer.dart';

import '../screen/pots_screen.dart';

import '../widgets/searchview_overview.dart';

class Searchviewscreen extends StatefulWidget {
  static const route = "searchviewscreen";
  @override
  _SearchviewscreenState createState() => _SearchviewscreenState();
}

class _SearchviewscreenState extends State<Searchviewscreen> {
  TextEditingController search = TextEditingController();
  String searching;
  bool isinit = true;
  @override
  void didChangeDependencies() {
    if(isinit==true){
    final searchquery = ModalRoute.of(context).settings.arguments as String;
    search.text = searchquery;
    searching = searchquery;
    isinit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top + kToolbarHeight);
    final h1 = MediaQuery.of(context).size.height - height;
    print(h1);
    print(height);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Container(
          height: h1 - 20,
          child: TextField(
            controller: search,
            autofocus: true,
            onChanged: (value) {
              Navigator.of(context)
                  .pushReplacementNamed(Potsscreen.route, arguments: value);
            },
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
              hintText: "...search pots",
              hintStyle: TextStyle(fontSize: 20),
            ),
            keyboardType: TextInputType.text,
          ),
        ),
      ),
      body: Searchviewoverview(searching),
      drawer:Appdrawer() ,
      
    );
  }
}
