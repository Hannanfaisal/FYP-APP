import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp/models/announcements_model.dart';
import 'package:http/http.dart' as http;

class AnnouncementProvider with ChangeNotifier{

  // List<AnnouncementsModel> _postList = [];
  // List<AnnouncementsModel> get postList => _postList;
  List _postList = [];
  List get postList => _postList;

//  <List<AnnouncementsModel>?>
  Future getPost() async{
    try{

      final response = await http.get(Uri.parse('http://192.168.100.26:5000/announcements'));
      // var data = jsonDecode(response.body.toString());
      if(response.statusCode == 200){
        // for(Map<String,dynamic> i in data){
        //   // model _model =model(title: i['title'], content: i['content']);
        //
        //   _postList.add( AnnouncementsModel.fromJson(i));
        //
        //
        //   // final List<dynamic> data = jsonDecode(response.body);
        //   // _postList = data.map((e) => AnnouncementsModel.fromJson(e)).toList();
        //
        // }

        final List<dynamic> data = jsonDecode(response.body);
        _postList = data.map((e) => AnnouncementsModel.fromJson(e)).toList();

        _postList = data;




      }
      else{
        debugPrint(response.statusCode.toString());
      }

    }catch(e){
      debugPrint(e.toString());
    }
  }
  
  
}