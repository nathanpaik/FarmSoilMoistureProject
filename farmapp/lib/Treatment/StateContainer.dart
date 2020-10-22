import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:farmapp/models/Treatment.dart';

class TreatmentStateContainer extends StatefulWidget {

  final Widget child;
  final List<Treatment> treatments;

  TreatmentStateContainer({
    @required this.child,
    this.treatments,
  });

  static TreatmentStateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedTreatmentStateContainer)
            as _InheritedTreatmentStateContainer)
        .data;
  }

  @override
  TreatmentStateContainerState createState() => new TreatmentStateContainerState();
}

class TreatmentStateContainerState extends State<TreatmentStateContainer> {

  List<Treatment> treatments;

  void addtoTreatmentList(Treatment treatment) {
 /*   Map<String, dynamic> features = {
      "treatmentName": treatmentName,
      "cropType": cropType,
      "numberRows": numberRows,
      "numberSeeds": numberSeeds,
      "irrigationSchedule": irrigationSchedule,
      "bedDim": bedDim
    }; */
      if (treatments == null) {
      setState(() {
          treatments = <Treatment>[treatment];
      });
    } else {
    
    setState(() {
        treatments.add(treatment);
    });
    print(treatments);
  }
}

void clear(){
  if (treatments != null) treatments.clear();
}


  @override
  Widget build(BuildContext context) {
    return new _InheritedTreatmentStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedTreatmentStateContainer extends InheritedWidget {
  final TreatmentStateContainerState data;

  _InheritedTreatmentStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedTreatmentStateContainer old) => true;
}
