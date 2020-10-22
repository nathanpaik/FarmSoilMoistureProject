// Flutter code sample for TextFormField

// This example shows how to move the focus to the next field when the user
// presses the ENTER key.
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart'; // to implement location field

import 'package:farmapp/main.dart';
import 'package:farmapp/models/User.dart';
import 'package:farmapp/models/Site.dart';
import 'package:farmapp/SizeConfig.dart';
import 'BoardingPage.dart';

class SiteForm extends StatefulWidget {
  SiteForm({Key key}) : super(key: key);

  @override
  _SiteFormState createState() => _SiteFormState();
}

class _SiteFormState extends State<SiteForm> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Site _site = new Site();
//  List<double> coordinates = [0,0]; 
  
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    final double horizontalMargin = SizeConfig.safeBlockHorizontal*10;
    final double verticalMargin = SizeConfig.safeBlockVertical*2;
    final double screenWidth = SizeConfig.screenWidth;
    final double sizedBoxHeight = SizeConfig.safeBlockVertical*3;

    
    final token = Provider.of<User>(context, listen: false).token;
    
    return new Scaffold(
      appBar: new AppBar( title: new Text('Add Site')),
      body:  Material(
        child: Container(
          margin: EdgeInsets.fromLTRB(horizontalMargin, verticalMargin, horizontalMargin, verticalMargin),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: verticalMargin),
                child: Center(
                child: Text(
                  "ENTER SITE INFORMATION",
                  style: TextStyle(height: 5, fontSize: 20),
                )
              )
            ),
            Expanded(
              child: Shortcuts(
                shortcuts: <LogicalKeySet, Intent>{
                  LogicalKeySet(LogicalKeyboardKey.enter):NextFocusIntent(),
                },
                child: FocusTraversalGroup(
                  child: Form(
              key: this._formKey,
              autovalidate: true,
              onChanged: () {
                Form.of(primaryFocus.context).save();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: verticalMargin),
                child: ListView(
                  children: <Widget>[                                                               TextFormField(
                      decoration: new InputDecoration(
                        labelText: 'Site Name'
                      ),                        
                      onSaved: (String value) {
                          _site.name = value;
                        },
                      ),
                      SizedBox(height: sizedBoxHeight),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: 'Site State'
                        ),
                        onSaved: (String value) {
                          _site.state = value;
                              },
                            ),
                            SizedBox(height: sizedBoxHeight),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: 'Site City'
                        ),
                        onSaved: (String value) {
                          _site.city = value;
                              },
                       ),

   /*Possible implementation of location field                    

                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text("Site Location"),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 50,
                                  child: TextFormField(
                                    inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,5}'))],
                                    keyboardType: TextInputType.number,       
                                    initialValue: coordinates[0].toString(),
                                    onSaved: (String value) {
                                      coordinates[0] = double.parse(value);
                                    },
                                )),
                            Text("   X   "),
                            Container(
                              width: 50,
                              child: TextFormField(
                                inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,5}'))],
                                keyboardType: TextInputType.number,
                                initialValue: coordinates[1].toString(),
                                onSaved: (String value) {
                                  coordinates[1] = double.parse(value);
                                },
                              )
                            ),
                            Expanded(
                              child: Container(
                                child: RaisedButton(
                                  child: Text("Get location automatically"),
                                  onPressed: () async {
                                  Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                                  setState(() => {
                                      coordinates[0] = position.longitude;
                                      coordinates[1] = position.latitude;
                                    }
                                  );
                                }
                              )
                            ),
                          )
                      ])
                    ]), */
      
                      ]
                    )
                  )
                    )
                  )
                )
              )
            ]
          )
        )
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () async {
          final form = _formKey.currentState;
          if (form.validate()) {
            _site.location = {
              "coordinates": [0,0] // default until changed
            };
            await submitSite(_site, token, context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BoardingPage() 
              )  
            );
          } 
        },
      ),
    );
  }
}
