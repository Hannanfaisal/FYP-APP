
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp/utils/constants.dart';
import 'package:fyp/view/official_view/official_dashboard.dart';
import 'package:fyp/view/official_view/official_events_history.dart';
import 'package:fyp/view/official_view/official_profile_screen.dart';

import 'package:fyp/view/official_view/official_settings_screen.dart';
import 'package:fyp/view/official_view/profile.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



class OfficialHomeScreen extends StatefulWidget {
  const OfficialHomeScreen({super.key});

  @override
  State<OfficialHomeScreen> createState() => _OfficialHomeScreenState();
}

class _OfficialHomeScreenState extends State<OfficialHomeScreen> {

  dynamic user;
  List<String>? splitImage;
  Future<void> getById()async {

    try{

      WidgetsFlutterBinding.ensureInitialized();

      SharedPreferences sp = await SharedPreferences.getInstance();
      final id = sp.getString('_id') ?? '';
      print(id);
      final response = await http.get(Uri.parse('${androidURL}party/${id}'));


      if(response.statusCode == 200){

        user = jsonDecode(response.body)['party'];

        // user = {
        //   'name' : data['party']['name'],
        //   'identification': data['party']['identification']
        //
        // };

        String image =  user['identification'].toString();
        splitImage = image.split(',');

        setState(() {

        });

      }
      else{
        debugPrint(response.statusCode.toString());
      }
    }catch(e){
      debugPrint(e.toString());
    }

  }

  bool isLoading = false;
  int selectedIndex = 0;


  final screens = [

    OfficialDashboard(),
    OfficialEventsHistory(),
  //  OfficialProfileScreen(id: user['name'].toString(), name: name, email: email, description: description, password: password, image: image)
    OfficialSettingsScreen()
  ];



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.shifting,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.teal,
        showSelectedLabels: true,
        onTap: (index){
          selectedIndex = index;
          setState(() {

          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled),label: 'Home',backgroundColor: Colors.white),
          BottomNavigationBarItem(icon: Icon(Icons.how_to_vote_outlined),label: 'Elections'),

          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
        ],
      ),
    );
  }
}
