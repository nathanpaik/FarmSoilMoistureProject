import 'package:flutter/material.dart';
import 'package:farmapp/LoginPage.dart';
import 'package:farmapp/main.dart';
import 'SiteSelection.dart';
import 'SiteForm.dart';

import 'package:farmapp/HomePage/HomePage.dart';
import 'package:farmapp/SizeConfig.dart';

class BoardingPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context){

    SizeConfig().init(context);
    final double horizontalMargin = SizeConfig.safeBlockHorizontal*3;
    final double verticalMargin = SizeConfig.safeBlockVertical*15;
    final double screenWidth = SizeConfig.screenWidth;
    final double sizedBoxHeight = SizeConfig.safeBlockVertical*2;
    
    return Scaffold(
      appBar: AppBar(title: Text("Select your site")),
      body: Container(
        margin: EdgeInsets.fromLTRB(horizontalMargin, verticalMargin,horizontalMargin,verticalMargin),
        padding: EdgeInsets.all(horizontalMargin),
        child: Column(
        children: <Widget>[
          Expanded(
            child: SiteSelection()
          ),
          Column(
            children: <Widget>[
              
              Container(
                width: screenWidth*0.75,
                child: RaisedButton(
                child: Text("Save and go to Home Page"),
                onPressed: () =>
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage()
                    )
                  )
                )
              ),
              SizedBox(height: sizedBoxHeight),
              Container(
                width: screenWidth*0.75,
                child: RaisedButton(
                  child: Text("Add new Site"),
                  onPressed: () =>
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SiteForm()
                    )
                  )
                  )
                ),
                SizedBox(height: sizedBoxHeight),
              Container(
                width: screenWidth*0.75,
                child: RaisedButton(
                child: Text("Back to login screen"),
                onPressed: () =>
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage() 
                    )
                  )
                )
              ),
              
            ]
            )
          ]
        )
      )
    );
}

}

  
