import 'dart:collection';
import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:farmapp/main.dart';
import 'package:farmapp/HomePage/HomePage.dart';
import 'package:farmapp/Treatment/StateContainer.dart';
import 'package:farmapp/widgets/displayDialog.dart';

class Treatment {

  String siteId;
  DateTime dateofPlanting;
    
  Map<String, dynamic> features = {
/*    "treatmentName": '',
    "cropType": '',
    "numberRows": 0,
    "numberSeeds": 0,
    "irrigationSchedule": {
      "times": 0,
      "period": ''
    },
   "bedDim": List<num>() */
  };

  Treatment([this.dateofPlanting, this.features , this.siteId]);

  factory Treatment.fromJson(Map<String, dynamic> json) {
    return Treatment(
      json['dateofPlanting'],
      json['features'],
      json['site']
    );
  }

  Map<String,dynamic> toJson(){

    return {
        "site": this.siteId,
        "dateofPlanting": this.dateofPlanting.toIso8601String(),
        "features": this.features,
    };
  }
  
}

Future<List<Treatment>> fetchTreatments(jwt, siteId) async {

    print("fetchingtreatments");
    final Map<String,String> headers = {
      "x-access-token": jwt,
      "Content-Type": "application/json"
    };
    final response = await http.get("https://www.farmsoilmoisture.tk/mobile/treatments/dropdown/${siteId}", headers: headers);
    if (response.statusCode == 200) {
      print(response.body);
      Iterable l = json.decode(response.body);
      return List<Treatment>.from(l.map((i) => Treatment.fromJson(i)));
    } else {
      return List<Treatment>();
    }
    
  }


void submitTreatments(List<Treatment> treatments, String token, BuildContext context) async {

  print("submittingtreatments");
  final Map<String,String> headers = {
    "x-access-token": token,
    "Content-Type": "application/json"
  };

  String json = jsonEncode(treatments.map((i) => i.toJson()).toList()).toString();

  var res = await http.post(
    "$SERVER_DOMAIN/treatments/all",
    body: json,
    headers: headers
     );
     print(res.statusCode);
     print(res.body);
     if(res.statusCode == 200){
       displayDialog(context,"Success", "Submitted treatments successfully");
       await Future.delayed(Duration(seconds: 2));
       final container = TreatmentStateContainer.of(context);
       container.clear();
       Navigator.pushReplacement(
         context,
         MaterialPageRoute(
           builder: (context) => HomePage()
        )
      );

     }
     else {
        displayDialog(context, "An error occured", "Could not add the treatments, please try again or try later.");
      };
      
}
