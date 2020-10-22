import 'package:flutter/material.dart';
import 'dart:convert' show json, base64, ascii;
import 'package:provider/provider.dart';


import 'package:farmapp/Boarding/BoardingPage.dart';
import 'package:farmapp/Treatment/StateContainer.dart';
import 'package:farmapp/Treatment/SubmitTreatment.dart';
import 'package:farmapp/models/User.dart';

import 'LoginPage.dart';
import 'main.dart';


class MyApp extends StatelessWidget {

  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "jwt");
    if(jwt == null) return "";
    return jwt;
  }

  @override
  Widget build(BuildContext context) {
    return new MultiProvider(
      providers : [
        Provider<User>(create: (context) => User()),
      ],
      child:   TreatmentStateContainer(
        child: MaterialApp(
          title: 'FarmApp Demo',
          theme: new ThemeData(
            primarySwatch: Colors.green,
          ),
          home: Consumer<User>(
          builder: (context1, user, child) {
            return FutureBuilder(
            future: jwtOrEmpty,            
            builder: (context, snapshot) {
              if(!snapshot.hasData) return CircularProgressIndicator();
              if(snapshot.data != "") {
                var str = snapshot.data;
                var jwt = str.split(".");
                
                if(jwt.length !=3) {
                  return LoginPage();
                } else {
                  var payload = json.decode(ascii.decode(base64.decode(base64.normalize(jwt[1]))));

                  user.payload = payload;
                  user.jwt = str;
                  user.token = json.decode(str)['token'];
                  
                  if(DateTime.fromMillisecondsSinceEpoch(payload["exp"]*1000).isAfter(DateTime.now())) {
                    return BoardingPage();
                  } else {
                    return LoginPage();
                  }
                }
              } else {
                return LoginPage();
              }
            }
          );
        }
      )
  ))
);
  }
}
