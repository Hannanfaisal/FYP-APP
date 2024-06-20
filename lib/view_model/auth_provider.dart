import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:fyp/components/snack.dart';
import 'package:fyp/view/official_view/official_home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier{
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  setLoggedIn({auth}){

    _isLoggedIn = auth;

    notifyListeners();
  }
  
  officialLogin(BuildContext context, String email, String password) async{
  
    try{
      
      final response = await http.post(Uri.parse('http://192.168.100.26:5000/official-login'), headers: {
        'Content-Type': 'application/json'
      }, body:jsonEncode({
        "email": email,
        "password": password
      }));

      if(response.statusCode == 200){
        var data = jsonDecode(response.body);

        print(data);
        final token = data['token'];
        final id = data['official']['_id'];
        print('Official Id in login screen: ${id}');
       SharedPreferences sp = await SharedPreferences.getInstance();
       sp.setString('officialToken', token.toString());
       sp.setString('_id', id.toString());



       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const OfficialHomeScreen()), (route) => false);
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const OfficialHomeScreen()));
      }else{
        debugPrint(response.reasonPhrase);
        showSnackBar(context: context, title: 'Failed to login', color: Colors.red);
      }
      
    }catch(e){
      debugPrint(e.toString());
    }
    
  }
}