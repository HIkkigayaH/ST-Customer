import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  bool isauth = false;
  String uuid;

  Future<User> signin() async {
    await Firebase.initializeApp();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authresult =
        await _auth.signInWithCredential(authCredential);

    final User user = authresult.user;

    if (user != null) {
      assert(await user.getIdToken() != null);
      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
      print('signInWithGoogle succeeded: $user');
      uuid = user.uid;
      var prefs = await SharedPreferences.getInstance();
      prefs.setString('uid', uuid);
    } else {
      print("object");
    }
    return user;
  }

  Future<void> signOut() async {
    await _auth.signOut();

    await googleSignIn.disconnect();
    await googleSignIn.signOut();
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove('uid');
  }

  Future<String> autoLogin() async {
    var prefs = await SharedPreferences.getInstance();

    String _uid = prefs.getString('uid');

    return _uid.toString();
  }
}
