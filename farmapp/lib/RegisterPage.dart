import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:farmapp/Boarding/BoardingPage.dart';
import 'package:farmapp/widgets/displayDialog.dart';
import 'main.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  String _email, _password, _username;

  Future<int> attemptSignUp(String username, String email, String password) async {
    var res = await http.post(
      '$SERVER_DOMAIN/api/auth/register',
      body: {
        "name": username,
        "email": email,
        "password": password
    });
    print(res.statusCode);
    return res.statusCode;
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Register"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 100),
          child: Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'username:'
                    ),
                    validator: (input) => input.length < 4 ? 'You need at least 4 characters' : null,
                    onSaved: (input) => _username = input,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'email:'
                    ),
                    validator: (input) => input.isEmpty || !input.contains("@")
              ? "enter a valid eamil" : null,
                    onSaved: (input) => _email = input,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Password:'
                    ),
                    validator: (input) => input.length < 6 ? 'You need at least 6 characters' : null,
                    onSaved: (input) => _password = input,
                    obscureText: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: _submitSignup,
                          child: Text('Sign Up'),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
      ))
    );
  }

  void _submitSignup() async {
    if(formKey.currentState.validate()){
      formKey.currentState.save();

      var res = await attemptSignUp(_username, _email,  _password);
      print(res);
      if(res == 200){
      print("lann");
      displayDialog(context, "Success", "The user was created. Log in now.");
      }else if(res == 400){
        displayDialog(context, "That username is already registered", "Please try to sign up using another username or log in if you already have an account."); 
      }
      else {
        displayDialog(context, "Error", "An unknown error occurred.");
      }
    }
  }
}
