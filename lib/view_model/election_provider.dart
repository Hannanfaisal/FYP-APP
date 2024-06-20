


import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fyp/models/elections_model.dart';
import 'package:fyp/utils/constants.dart';
import 'package:http/http.dart' as http;

class ElectionProvider with ChangeNotifier{

  List<ElectionsModel> _elections = [];

  List<ElectionsModel> get elections  => _elections;

  List _partyElections = [];
  List get partyElections => _partyElections;

  Future<void> getElections() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.100.26:5000/elections'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _elections = data.map((e) => ElectionsModel.fromJson(e)).toList();
        print(data);
      } else {
        debugPrint(response.statusCode.toString());
      }
    } catch (e) {
      debugPrint('Error while fetching elections: $e');
    }
  }


  Future<void> getPartyElections() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.100.26:5000/elections'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        _partyElections = data;

      } else {
        debugPrint(response.statusCode.toString());
      }
    } catch (e) {
      debugPrint('Error while fetching elections: $e');
    }
  }
  //
  // updateStatus ({required id,required String status}) async{
  //   try{
  //     final response = await http.put(Uri.parse("${androidURL}update/status"),
  //     headers: {
  //       'Content-Type': 'application/json'
  //     },body: jsonEncode({
  //           'id': id,
  //           'status': status
  //         }));
  //
  //     if(response.statusCode == 200){
  //       debugPrint('Status updated');
  //     }
  //     else{
  //       debugPrint(response.statusCode.toString());
  //     }
  //   }
  //   catch(e){
  //     debugPrint(e.toString());
  //   }
  // }
  //
  //
  //



  // Future<void> startElection() async{
  //
  // }
  
  
}