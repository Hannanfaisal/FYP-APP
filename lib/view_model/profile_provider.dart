

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp/components/snack.dart';
import 'package:fyp/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier{

  dynamic user;
  List<String>? splitImage;

  Future<void> updateProfile(BuildContext context, String phone, String email) async{
    try{

      SharedPreferences sp = await SharedPreferences.getInstance();

      final id = await sp.getString('voterId') ?? '';
      print(id);

      final response = await http.put(Uri.parse('${androidURL}update-profile'), headers: {
        'Content-Type': 'application/json'
      }, body: jsonEncode({
        'phone': phone,
        'email': email,
        'id': id
      }));

      if(response.statusCode == 200){
        showSnackBar(context: context, title: 'Profile Updated');
      }
      else{
        showSnackBar(context: context, title: 'Something went  ${response.statusCode}', color: Colors.red);
      }

    }
    catch(e){
      debugPrint(e.toString());
      showSnackBar(context: context, title: 'Something went wrong', color: Colors.red);
    }
  }

  Future<void> getProfile() async{
    try{

      SharedPreferences sp = await SharedPreferences.getInstance();

      final id = await sp.getString('voterId') ?? '';

      final response = await http.get(Uri.parse('${androidURL}voter/${id}'));

      if(response.statusCode == 200){
        var data = jsonDecode(response.body)['voter'];
        user = data;
        print(user);
      }
      else{
        debugPrint(response.statusCode.toString());
      }
    }catch(e){
      debugPrint(e.toString());
    }
  }

  Future<void> getOfficialProfile() async{
    try{

      SharedPreferences sp = await SharedPreferences.getInstance();
      final id = sp.getString('_id') ?? ''; //officialId
      print(id);

      final response = await http.get(Uri.parse('${androidURL}party/${id}'));

      if(response.statusCode == 200){
        var data = jsonDecode(response.body)['party'];
        user = data;
        String image =  user['identification'].toString();
        splitImage = image.split(',');


        print(user['identification']);
      }
      else{
        debugPrint(response.statusCode.toString());
      }
    }catch(e){
      debugPrint(e.toString());
    }
  }

}