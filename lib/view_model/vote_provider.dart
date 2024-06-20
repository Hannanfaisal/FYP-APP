



import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp/utils/constants.dart';
import 'package:fyp/view/feedback_screen.dart';
import 'package:fyp/view/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VoteProvider with ChangeNotifier {
  int count = 0;

  bool isVoted = false;


  String selected_candidate = "";


  setVoted(){
    isVoted = false;
  }

  vote({required BuildContext context, required  electionId,required int index}) async{

    try{

      SharedPreferences sp = await SharedPreferences.getInstance();

      final voterId = await sp.getString('voterId') ?? '';


      final response = await http.post(Uri.parse('${androidURL}vote/candidate/${electionId}'), headers: {
        'Content-Type': 'application/json'
      },body: jsonEncode({
        'index': index,
        'voterId': voterId
      }));



      if(response.statusCode == 201){

        isVoted = true;

         notifyListeners();
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (BuildContext context) =>  FeedbackScreen(id: electionId,)),
                (Route<dynamic> route) => route is HomeScreen
        );


        showModalBottomSheet(context: context, builder:(context){
          return SizedBox(
            width: double.infinity,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Center(child: Text(AppLocalizations.of(context)!.vote_recorded, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 28),)),
                        //   Center(child: Icon(Icons.check_circle_outline , color: primaryColor, size: 60,)),
                        Lottie.asset('assets/animations/confirm_animation.json', height: 85, fit: BoxFit.fill, width: 85, repeat: false),
                           Center(child: Text(AppLocalizations.of(context)!.thank_you, style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black45,  fontStyle: FontStyle.italic ,  fontSize: 14),)),
                        ],
                      ),
            ),
          );
        });

      }
      else{
        debugPrint(response.statusCode.toString());
      }

    }
    catch(e){
      debugPrint(e.toString());
    }

  }

  Future<void> totalVotes({required String electionId}) async {
    try {
      final response = await http.get(
          Uri.parse("${androidURL}totalVotes/$electionId"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['TotalVotes'];
        count = data;
        notifyListeners();
      } else {
        debugPrint(response.statusCode.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
    //
    // Future<void> resultList({required String electionId}) async {
    //   try {
    //     final response = await http.get(Uri.parse("${androidURL}resultListByElection/$electionId"));
    //     if (response.statusCode == 200) {
    //       var jsonData = jsonDecode(response.body)['results'];
    //       if (jsonData is List) {
    //         List<Result> newResult = jsonData.map<Result>((item) => Result.fromJson(item)).toList();
    //         if (!_areResultsEqual(_result, newResult)) {
    //           _result = newResult;
    //           _resultStreamController.add(_result);
    //           notifyListeners();
    //         }
    //         debugPrint(result.toString());
    //       } else {
    //         debugPrint('Unexpected data format: $jsonData');
    //       }
    //     } else {
    //       debugPrint(response.statusCode.toString());
    //       debugPrint(response.reasonPhrase);
    //     }
    //   } catch (e) {
    //     debugPrint(e.toString());
    //   }
    // }

    Future<void> selectedCandidate({required String electionId}) async {
      try {
        final response = await http.get(
            Uri.parse("${androidURL}selected/candidate/$electionId"));
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body)['selectedCandidate'];
          debugPrint(data);
          selected_candidate = data;
          notifyListeners();
        } else {
          debugPrint(response.statusCode.toString());
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    // bool _areResultsEqual(List<Result> oldResults, List<Result> newResults) {
    //   if (oldResults.length != newResults.length) return false;
    //   for (int i = 0; i < oldResults.length; i++) {
    //     if (oldResults[i].name != newResults[i].name || oldResults[i].votes != newResults[i].votes) {
    //       return false;
    //     }
    //   }
    //   return true;
    // }
    //
    // @override
    // void dispose() {
    //   _resultStreamController.close();
    //   super.dispose();
    // }
  }
  //
  // class Result {
  // final String name;
  // final int votes;
  //
  // Result({required this.name, required this.votes});
  //
  // factory Result.fromJson(Map<String, dynamic> json) {
  // return Result(
  // name: json['name'] ?? '',
  // votes: json['value'] ?? 0,
  // );
  // }
  //
  // @override
  // String toString() {
  // return 'Name: $name, Votes: $votes';
  // }
  //
  // }
