import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:farmapp/Boarding/BoardingPage.dart';
import 'package:farmapp/widgets/displayDialog.dart';

import 'main.dart';
import 'RegisterPage.dart';
import 'MyApp.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String _email, _password, _username;

  Future<String> attemptLogIn(String username, String password) async {

    print(username + password);
    var res = await http.post(
      "$SERVER_DOMAIN/api/auth/login",
      body: {
        "name": username,
        "password": password
      }
    );
    print(res.body);
    if(res.statusCode == 200) return res.body;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Login"),
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
                          onPressed: _submitLogin,
                          child: Text('Sign in'),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: gotoRegister,
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

  void gotoRegister() {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterPage() 
      )
    );

  }

  void _submitLogin() async {
    if(formKey.currentState.validate()){
      formKey.currentState.save();

      var jwt = await attemptLogIn(_username, _password);
      if(jwt != null) {
        storage.write(key:"jwt", value: jwt);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyApp() 
          )
        );
      } else {
        displayDialog(context, "An error occured", "No account was found matching that username and password.");
      }
    }
    
  }

}
