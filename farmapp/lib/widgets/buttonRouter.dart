import 'package:flutter/material.dart';
import 'package:farmapp/SizeConfig.dart';

Widget buttonRouter(String text, Widget page, BuildContext context){

  SizeConfig().init(context);

  return Container(
    width: SizeConfig.screenWidth*0.8,
    child: RaisedButton(
      child: Text(text),
      onPressed: () =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page 
        )
      )
    )
  );

}
