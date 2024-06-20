

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fyp/models/candidates_model.dart';
import 'package:fyp/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CandidateProvider with ChangeNotifier{

  List<CandidatesModel> _candidates = [];

  List<CandidatesModel> get candidates => _candidates;


  List<CandidatesModel> _candidatesByParty = [];

  List<CandidatesModel> get candidatesByParty => _candidatesByParty;



  Future<void> getCandidates()async{
    try{

      final response = await http.get(Uri.parse('${androidURL}candidates'));

      if(response.statusCode == 200){

        final List<dynamic> data = jsonDecode(response.body);
        _candidates = data.map((e) => CandidatesModel.fromJson(e)).toList();
      }else {
        debugPrint(response.statusCode.toString());
      }

    }
    catch(e){
      debugPrint(e.toString());
    }
  }


  Future<void> getCandidatesByParty()async{
    try{

      SharedPreferences sp  = await SharedPreferences.getInstance();
      var partyId = sp.getString('_id') ?? '';
      print(partyId);

      final response = await http.get(Uri.parse('${androidURL}candidates/$partyId'));

      if(response.statusCode == 200){

        final List<dynamic> data = jsonDecode(response.body);
        _candidatesByParty = data.map((e) => CandidatesModel.fromJson(e)).toList();
      }else {
        debugPrint(response.statusCode.toString());
      }

    }
    catch(e){
      debugPrint(e.toString());
    }
  }



}
