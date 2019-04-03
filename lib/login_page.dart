import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget{
  LoginPage({this.auth});
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormType{
  login,
  register
}

class _LoginPageState extends State<LoginPage>{

  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave(){
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async{
    if (validateAndSave()){
      try{
        if (_formType == FormType.login){
        String userId = await widget.auth.signInWithEmailAndPassword(_email, _password);
        print('Signed in: $userId');
      }else{
        String userId = await widget.auth.createUserWithEmailAndPassword(_email, _password);
          FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
          print('Registered user: $userId');
      }
      }
      catch (e){
        print('Error: $e');
      }
    }
  }

  void moveToRegister(){
    formKey.currentState.reset();
    setState((){
      _formType = FormType.register;
    });
  }

  void moveToLogin(){
    formKey.currentState.reset();
    setState((){
      _formType = FormType.login;
    });
  }


  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text('Touch Login Demo',)
      ),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          child: new Column(
            crossAxisAlignment:CrossAxisAlignment.stretch,
            children: buildInputs() + buildSubmitButtons()
          ),
      )
      )
    );
  }

  List<Widget> buildInputs(){
    return[
      new TextFormField(
      decoration: new InputDecoration(labelText: 'Email'),
      validator:(value) => value.isEmpty ? 'Email can\'t be empty' : null,
      onSaved: (value) => _email = value,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Password'),
        validator:(value) => value.isEmpty ? 'Password can\'t be empty' : null,
        obscureText:true,
        onSaved: (value) => _password = value,
      ),
    ];
  }

  List<Widget> buildSubmitButtons(){
    if (_formType == FormType.login){
    return[
  new RaisedButton(
    child: new Text('Login', style: new TextStyle(fontSize: 20.0)),
    onPressed: validateAndSubmit,
  ),
  new FlatButton(
    child: new Text('Create Account', style: new TextStyle(fontSize: 20.0)),
    onPressed: moveToRegister,
  )
    ];
  }else{
 return[
  new RaisedButton(
    child: new Text('Create An Account', style: new TextStyle(fontSize: 20.0)),
    onPressed: validateAndSubmit,
  ),
  new FlatButton(
    child: new Text('Have an Account? Login', style: new TextStyle(fontSize: 20.0)),
    onPressed: moveToLogin,
  )
    ];
  }
  
}
}
