import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp/components/snack.dart';
import 'package:fyp/view/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedbackProvider with ChangeNotifier {




  postFeedback({required BuildContext context, double ratings = 0 ,required String content, required electionId}) async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      final voterId = await sp.getString('voterId') ?? '';

      final response = await http.post(
          Uri.parse('http://192.168.100.26:5000/post-feedback'), headers: {
        'Content-Type': 'application/json'
      },
          body: jsonEncode({
            'rating': ratings,
            'content': content,
          //  'date': "${DateFormat('yyyy-MM-dd').format(DateTime.now())}",
            'voter': voterId,
            'election': electionId
          }));

      if (response.statusCode == 201) {



        showSnackBar(context: context, title: 'Feedback submitted');

        Future.delayed(Duration(seconds: 2));
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            Dashboard()), (Route<dynamic> route) => false);
      }
      else {
        showSnackBar(context: context, title: 'Error occurred ${response.statusCode}');
      }
    }

    catch (e) {
      debugPrint(e.toString());
    }
  }

}


