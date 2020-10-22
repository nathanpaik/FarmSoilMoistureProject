import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:farmapp/main.dart';
import 'package:farmapp/models/Site.dart';
import 'package:farmapp/models/User.dart';
import 'package:farmapp/Treatment/StateContainer.dart';
import 'package:farmapp/SizeConfig.dart';

class SiteSelection extends StatelessWidget {
    
  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    final double sizedBoxHeight = SizeConfig.safeBlockVertical*2;

    return Scaffold(
      body: Column(
          children: <Widget>[
            Text("Select a site", style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
            SizedBox(height: sizedBoxHeight),
            Container(child: MyDropdown())       
          ]
        )
      );
    
    }
  
  }
  
class MyDropdown extends StatefulWidget {
  MyDropdown({Key key}) : super(key: key);

  @override
  _MyDropdownState createState() => _MyDropdownState();
}
  

class _MyDropdownState extends State<MyDropdown> {

  Site selectedSite;
  Future<List<Site>> siteFuture;
    
  @override
  void initState() {
    print("hereinit");
    super.initState();
  }

  @override    
  void didChangeDependencies() async {

    final user = Provider.of<User>(context, listen:true);
    print("token" + user.token);
    siteFuture = fetchSites(user.token);
    print("heredidchange");
    super.didChangeDependencies();
    
  }

  @override
  Widget build(BuildContext context) {

    final container = TreatmentStateContainer.of(context);
    SizeConfig().init(context);
    final double horizontalMargin = SizeConfig.safeBlockHorizontal;
    final double verticalMargin = SizeConfig.safeBlockVertical*15;
    final double screenWidth = SizeConfig.screenWidth;
    final double sizedBoxHeight = SizeConfig.safeBlockVertical*2;
    
    print("herebuild");
    final user = Provider.of<User>(context, listen: false);    
    return FutureBuilder<List<Site>>(
      future: siteFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Site>> snapshot) {
        if(snapshot.hasData) {
          return Center(
            child: Container(
            width: screenWidth*0.8,
            decoration: BoxDecoration(
              border: Border.all(width: 3.0),
              borderRadius: BorderRadius.all(Radius.circular(horizontalMargin*2))
            ),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<Site>(
                  icon: Icon(Icons.arrow_downward),
                  iconSize: sizedBoxHeight,
                  elevation: 16,
                  style: TextStyle(color: Colors.black),
                  value: selectedSite,
                  onChanged: (Site newSite) {
                    setState(() {
                        user.siteN = newSite.name;
                        user.siteId = newSite.id;
                        container.clear();
                        selectedSite = newSite;
                    });
                    
                  },
                  items: snapshot.data.map<DropdownMenuItem<Site>>((Site site) {
                      return DropdownMenuItem<Site>(
                        value: site,
                        child: Text(site.name, style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
                      );
                  }).toList(),
                  hint: Text('Select Site')
                )
              )
            )
          )
        ); 
        } else if (snapshot.hasError) {
          return Text("there was an error");
          
        } else {
          return Column(
            children: <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: sizedBoxHeight*3,
                height: sizedBoxHeight*3,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ]
          );
        }
      }
    );
  }
}     
