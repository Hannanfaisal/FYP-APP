import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp/components/snack.dart';
import 'package:fyp/models/political_parties_model.dart';
import 'package:fyp/utils/constants.dart';
import 'package:fyp/view/official_view/official_home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PoliticalPartiesProvider with ChangeNotifier{

  List<PoliticalPartiesModel> _partiesList = [];

  List<PoliticalPartiesModel> get partiesList => _partiesList;
  
  Future<void> getParties() async{
    try{
      
      final response = await http.get(Uri.parse('http://192.168.100.26:5000/parties'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _partiesList = data.map((e) => PoliticalPartiesModel.fromJson(e)).toList();
        print(data);
      } else {
        debugPrint(response.statusCode.toString());
      }
    //  var data = jsonDecode(response.body.toString());

      // if(response.statusCode == 200){
      //
      //   for(Map<String,dynamic> i in data){
      //     _partiesList.add(PoliticalPartiesModel.fromJson(i));
      //   }
      //   debugPrint(response.statusCode.toString());
      //
      //   debugPrint(partiesList.length.toString());
      //   return partiesList;
      //
      // }else{
      //   debugPrint(response.statusCode.toString());
      // }

      
    }catch(e){
      debugPrint(e.toString());
    }

  }

   updateParty({required BuildContext context,required String name, String image="",required String email, required String description}) async {
    try{

      SharedPreferences sp = await SharedPreferences.getInstance();
      final id = sp.getString('_id') ?? '';
      print(id);

      final response = await http.put(Uri.parse('${androidURL}update-party'),
       headers: {
        'Content-Type': 'application/json'
       },
        body: jsonEncode({
          "id": id,
          "name": name,
          "email": email,
          // "identification": "path",
          "description": description
        })
      );

      if(response.statusCode == 200){
        showSnackBar(context: context, title: 'Profile updated');
      }
      else{

        showSnackBar(context: context, title: 'SomeThing went wrong ${response.statusCode} ${response.reasonPhrase}', color: Colors.red);
      }

    }
    catch(e){
      debugPrint(e.toString());
    }
  }

  changePassword(BuildContext context,String id, String currentPassword, String newPassword) async{
    try{
      final response = await http.put(Uri.parse('${androidURL}change-password'), headers: {
        'Content-Type': 'application/json'
      }, body: jsonEncode({
        'id':'6624ae40edb2331c1f29bea7',
        'oldPassword': currentPassword,
        'password': newPassword
      }));

      var data = jsonDecode(response.body);

      if(response.statusCode == 200){

        showSnackBar(context: context, title: 'Password changed');

        await Future.delayed(Duration(seconds: 3));
        Navigator.pop(context);
        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>OfficialHomeScreen()), (route) => false);
      }
      else{

        debugPrint(data['message']);
        showSnackBar(context: context, title: '${data['message']}' ,color: Colors.red);
      }

    }
    catch(e){
      showSnackBar(context: context, title: 'Something went wrong', color: Colors.red);
    }
  }
  
  
}