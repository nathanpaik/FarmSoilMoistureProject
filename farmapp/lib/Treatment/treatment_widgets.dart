import 'package:flutter/material.dart';
import 'package:farmapp/models/Treatment.dart';

Widget treatmentsList(List<Treatment> treatments, bool view) {
    return new ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: treatments.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
           leading: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {},
            child: Container(
              width: 48,
              height: 48,
              padding: EdgeInsets.symmetric(vertical: 4.0),
              alignment: Alignment.center,
              child: view ? Icon(Icons.view_comfy) : Icon(Icons.edit),
            ),
          ),
            title: Text('Treatment Name: ${treatments[index].features["treatmentName"]}'),
            dense: false
          );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider()
    );
  }
  
