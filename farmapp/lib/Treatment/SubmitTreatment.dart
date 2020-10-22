import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'StateContainer.dart';
import 'TreatmentForm.dart';
import 'treatment_widgets.dart';
import 'package:farmapp/models/Treatment.dart';
import 'package:farmapp/models/User.dart';
import 'package:farmapp/widgets/buttonRouter.dart';
import 'package:farmapp/SizeConfig.dart';

class SubmitTreatmentList extends StatefulWidget {

  @override
  SubmitTreatmentListState createState() => new SubmitTreatmentListState();
  
}

class SubmitTreatmentListState extends State<SubmitTreatmentList> {

  List<Treatment> treatments;  

  Widget get _currentTreatments{
    return treatmentsList(treatments, false);
  }
    
  void _treatmentForm(BuildContext context) {
   
    Navigator.push(
      context,
      new MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) {
          return new TreatmentForm();
        },
      ),
    );
  }
  

  Widget get treatmentFormTile {
    return ListTile(
          leading: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => _treatmentForm(context),
            child: Container(
              width: 48,
              height: 48,
              padding: EdgeInsets.symmetric(vertical: 4.0),
              alignment: Alignment.center,
              child: Icon(Icons.add),
            ),
          ),
          title: Text('Click to add new treatment'),
          dense: false,
        );
      }

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    final double horizontalMargin = SizeConfig.safeBlockHorizontal;
    final double verticalMargin = SizeConfig.safeBlockVertical*6;
    final double screenWidth = SizeConfig.screenWidth;
    final double sizedBoxHeight = SizeConfig.safeBlockVertical*2;

    final container = TreatmentStateContainer.of(context);
    final user = Provider.of<User>(context, listen: false);
    final siteN = user.siteN;
    final token = user.token;
    treatments = container.treatments;
     
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Inherited Widget Test'),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(horizontalMargin, verticalMargin, horizontalMargin, verticalMargin),
        padding: EdgeInsets.all(horizontalMargin*3),
        child: Column(
          children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[            
                  RichText(
                    text: new TextSpan(
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        new TextSpan(text: 'You are about to add treatments to '),
                        new TextSpan(text: siteN, style: new TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(height: sizedBoxHeight),
                  (treatments != null && treatments.length != 0 ? _currentTreatments : Text("No treatment in the list yet")),
            treatmentFormTile,
          ]
        ),
        SizedBox(height: sizedBoxHeight),
      Container(
        width: screenWidth*0.8,
        child: RaisedButton(
          child: Text("Save these treatments to site"),
          onPressed: () => submitTreatments(treatments, token, context)
      
        )
      )     
    ]
  )
),           
);
  } 
  
}
