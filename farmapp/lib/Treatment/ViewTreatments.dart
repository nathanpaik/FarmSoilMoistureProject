import 'package:flutter/material.dart';
import 'package:farmapp/models/Treatment.dart';
import 'package:provider/provider.dart';
import 'package:farmapp/models/User.dart';
import 'package:farmapp/SizeConfig.dart';
import 'treatment_widgets.dart';

class ViewPage extends StatelessWidget{
  
  @override
  Widget build(BuildContext context){

    SizeConfig().init(context);
    final double horizontalMargin = SizeConfig.safeBlockHorizontal;
    final double verticalMargin = SizeConfig.safeBlockVertical*6;
    final double screenWidth = SizeConfig.screenWidth;
    final double sizedBoxHeight = SizeConfig.safeBlockVertical*3;
    
    final user = Provider.of<User>(context, listen: false);
    final siteN = user.siteN;
    return Scaffold(
      appBar: AppBar(title: Text("View Treatments")),
      body: Container(
        margin: EdgeInsets.fromLTRB(horizontalMargin, verticalMargin, horizontalMargin, verticalMargin),
        padding: EdgeInsets.all(horizontalMargin*3),
        child: Column(
          children: [
            RichText(
              text: new TextSpan(
                style: new TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  new TextSpan(text: 'You are viewing the treatments at '),
                  new TextSpan(text: siteN, style: new TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(height: sizedBoxHeight),
            TreatmentList(),
          ]
        )
      )
    );
  }
}

class TreatmentList extends StatefulWidget {
  TreatmentList({Key key}) : super(key: key);

  @override
  _TreatmentListState createState() => _TreatmentListState();
}


class _TreatmentListState extends State<TreatmentList> {
  Future<List<Treatment>> _treatments;

  @override
  void initState(){
    final user = Provider.of<User>(context, listen: false);
    _treatments = fetchTreatments(user.token, user.siteId);
    super.initState();
  }
  
  Widget build(BuildContext context) {
    return FutureBuilder<List<Treatment>>(
        future: _treatments, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<List<Treatment>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            if(snapshot.data.isEmpty){
              children = <Widget>[ Text("No treatments have been added to this site yet.") ];
            }else {
            children = <Widget>[
              treatmentsList(snapshot.data, true)
            ];
          }
          } else if (snapshot.hasError) {
            children = <Widget>[
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        },
      );
    }
  }
