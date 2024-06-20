import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp/utils/constants.dart';
import 'package:http/http.dart' as http;


class VoterProvider with ChangeNotifier{

  int _voters = 0;
  int get voters => _voters;

  getVoters () async{
    try{
      final response = await http.get(Uri.parse("${androidURL}voters"));

      if(response.statusCode == 200){
        var data = jsonDecode(response.body)['voters'];
        _voters  = data.length;

      }
      else{
        debugPrint(response.statusCode.toString());
      }

    }
    catch(e){
      debugPrint(e.toString());
    }
  }
  
}