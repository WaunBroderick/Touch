import 'package:flutter/material.dart';
import 'package:touch/login_page.dart';
import 'auth.dart';
import 'root_page.dart';

void main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){

    return new MaterialApp(
      title: 'touch',
      theme: new ThemeData(
        primarySwatch:Colors.teal,
      ),
      home: new RootPage(auth: new Auth())
      );
  }
}