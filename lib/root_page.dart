import 'package:flutter/material.dart';
import 'login_page.dart';
import 'auth.dart';

class RootPage extends StatefulWidget{
  RootPage({this.auth});
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

enum AuthStatus{
  notSignedIn,
  signedIn
}

class _RootPageState extends State<RootPage>{
  
  AuthStatus authStatus = AuthStatus.notSignedIn;
  
  void initState(){
    super.initState();
    widget.auth.currentUser().then((userId){
      setState((){
        authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }


  @override
  Widget build(BuildContext context){
    switch (authStatus){
      case AuthStatus.notSignedIn:
      return new LoginPage(auth: widget.auth);
      case AuthStatus.signedIn:
      return new Scaffold(
      body: new Container(
        child: new Text("Welcome"),
      )
      );
    }
  }
}