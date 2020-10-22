import 'package:flutter/material.dart';
import 'package:farmapp/Treatment/ViewTreatments.dart';
import 'package:farmapp/Treatment/SubmitTreatment.dart';
import 'package:farmapp/Boarding/BoardingPage.dart';
import 'package:farmapp/SizeConfig.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    final double horizontalMargin = SizeConfig.safeBlockHorizontal;
    final double verticalMargin = SizeConfig.safeBlockVertical*5;
    final double screenWidth = SizeConfig.screenWidth;
    final double screenHeight = SizeConfig.screenHeight;
    final double sizedBoxHeight = SizeConfig.safeBlockVertical*2;

    return new Scaffold(
      appBar: AppBar(title: Text("Home Page"), automaticallyImplyLeading: false),
      body: Container(
        margin: EdgeInsets.fromLTRB(horizontalMargin, verticalMargin, horizontalMargin, verticalMargin),
        padding: EdgeInsets.all(horizontalMargin*3),
        child: Column(
          children: <Widget>[
            Container(
              width: screenWidth*0.9,
              height: screenHeight*0.25 ,
              child: FittedBox(
                fit: BoxFit.contain,
                alignment: Alignment.topLeft,
                child: Text(' Farm\n App'),
              )
            ),
            Container(
              width : screenWidth*0.9,
              height: screenHeight*0.5,
              child: 
              GridView.count(
              primary: false,
              padding: EdgeInsets.all(sizedBoxHeight),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                menuItem(" View\n Treatments\n in\n Site", context, ViewPage()),
                menuItem(' Add\n Treatment\n to\n Site', context, SubmitTreatmentList()),
                menuItem(' Change\n Site', context, BoardingPage()),
                menuItem('Settings', context, BoardingPage()),
              ],
            )
          )
          ]
        )
      )
    );
  }
}

Widget menuItem(String str, BuildContext context, Widget page) {

  SizeConfig().init(context);
  final double sizedBoxHeight = SizeConfig.safeBlockVertical*2;  
  
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page
        )
      );
    },
    child: Container(
      alignment : Alignment.centerLeft,
      padding : EdgeInsets.all(sizedBoxHeight),
      child: Text(str,
        style: TextStyle(fontSize: 20.0),
      ),
      color: Colors.teal[100],
    )
  );
  
}
