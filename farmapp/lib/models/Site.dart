import 'dart:collection';
import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:farmapp/main.dart';
import 'package:farmapp/widgets/displayDialog.dart';

class Site {

  String id;
  String name;
  String city;
  String state;
  Map<String, dynamic> location;  

  Site({this.id, this.name, this.city, this.state, this.location});

  factory Site.fromJson(Map<String, dynamic> json) {
    return Site(
      name: json['name'],
      id: json['_id']
    );
  }

  Map<String, dynamic> toJson() =>
  {
    'name': name,
    'city': city,
    'state': state,
    'location': location
  };
  
}

  Future<List<Site>> fetchSites(jwt) async {

    print(jwt);
    final Map<String,String> headers = {
      "x-access-token": jwt
    };
    final response = await http.get('$SERVER_DOMAIN/sites', headers: headers);
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<Site> sites = List<Site>.from(l.map((i) => Site.fromJson(i)));
      return sites;
    } else {
      throw Exception('Failed to load sites');
    }
    
  }
  
  void submitSite(Site site, String token, BuildContext context) async {

    print("submittingsite");
    final Map<String,String> headers = {
       "x-access-token": token,
       "Content-Type": "application/json"
     };
     String json = jsonEncode(site);
     var res = await http.post(
       "$SERVER_DOMAIN/sites",
       body: json,
       headers: headers
     );
     print(res.statusCode);
     print(res.body);
     if(res.statusCode != 200) {
        displayDialog(context, "An error occured", "Could not add the site.");
     };
   }
