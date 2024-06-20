
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fyp/components/snack.dart';
import 'package:http/http.dart' as http;

class ContactProvider with ChangeNotifier{


  bool _loading = false;

  bool get loading => _loading;

  
  postContact(BuildContext context, String email, String subject, String message) async{
    _loading = true;
    try{


      
      final response = await http.post(Uri.parse('http://192.168.100.26:5000/post-contact'),
      headers: {
        'content-type': 'application/json'
      },
        body: jsonEncode({
         "email": email,
          "subject": subject,
          "message": message,
          "voter": "65c9bbd1993d38f8b047683c"
        })
      );

      if(response.statusCode == 201){

        showSnackBar(context: context, title: 'Your response recorded');

        _loading = false;
      }
      else{
        showSnackBar(context: context, title: 'Something went wrong ${response.statusCode}');

        _loading = false;

      }

    }
    catch(e){
      debugPrint(e.toString());
      _loading = false;
    }

    notifyListeners();
  }
  
  
}