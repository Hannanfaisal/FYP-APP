


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp/components/alert_dialog.dart';
import 'package:fyp/utils/app_colors.dart';
import 'package:fyp/view/about_us_screen.dart';
import 'package:fyp/view/complete_profile.dart';
import 'package:fyp/view/contact_screen.dart';
import 'package:fyp/view/home_screen.dart';
import 'package:fyp/view/language_selection_screen.dart';
import 'package:fyp/view/login_screen.dart';
import 'package:fyp/view/official_view/official_dashboard.dart';
import 'package:fyp/view/official_view/official_home_screen.dart';
import 'package:fyp/view/official_view/official_profile_screen.dart';
import 'package:fyp/view/privacy_policy_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fyp/view/profile.dart';
import 'package:fyp/view/theme_mode_screen.dart';
import 'package:fyp/view_model/auth_provider.dart';
import 'package:fyp/view_model/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfficialSettingsScreen extends StatefulWidget {
  const OfficialSettingsScreen({super.key});

  @override
  State<OfficialSettingsScreen> createState() => _OfficialSettingsScreenState();
}

class _OfficialSettingsScreenState extends State<OfficialSettingsScreen> {





  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    List list = [
      {
        "title": AppLocalizations.of(context)!.language,
        "icon": Icons.language
      },
      {
        "title": AppLocalizations.of(context)!.themeMode,
        "icon": Icons.dark_mode_outlined
      },
      {
        "title": AppLocalizations.of(context)!.privacyPolicy,
        "icon": Icons.lock
      },
      {
        "title": AppLocalizations.of(context)!.contactUs,
        "icon": Icons.contact_support_outlined
      },
      {
        "title": AppLocalizations.of(context)!.aboutUs,
        "icon": Icons.info_outlined
      },
      {
        "title": AppLocalizations.of(context)!.logout,
        "icon": Icons.logout
      }

    ];

    final authProvider = Provider.of<AuthProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> OfficialHomeScreen()), (route) => false);

          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white,),
        ),
        title:  Text(AppLocalizations.of(context)!.settings, style: TextStyle(color: whiteColor),),
        backgroundColor: primaryColor,
      ),

      body:  SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(

            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.account, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: profileProvider.getOfficialProfile(),
                builder: (context, snapshot){
                  var user = profileProvider.user;
                  var image = profileProvider.splitImage;
                  return ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> OfficialProfileScreen(id: user['id'], name: user['name'], email: user['email'], description: user['description'], password: user['password'], image: image![image!.length-1])));
                    },
                    contentPadding: const EdgeInsets.all(0),
                    splashColor: const Color(0XFFdff7dc),
                    selectedTileColor: Colors.green ,
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: primaryColor)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child:  profileProvider.splitImage != null ? Image.memory( base64Decode(profileProvider.splitImage![profileProvider.splitImage!.length-1]),width: 40,height: 40,) : const CircularProgressIndicator() //profileProvider.splitImage != null ? Image.memory(base64Decode(profileProvider.splitImage![1].toString())) : Image.network('https://img.freepik.com/premium-vector/man-avatar-profile-picture-vector-illustration_268834-538.jpg')
                        ),
                      ),
                    ) ,
                    title: Text(profileProvider.user?['name'] ?? 'Loading...', style: TextStyle(fontWeight: FontWeight.w500),),

                    trailing: const Icon(Icons.arrow_forward_ios),
                  );
                },

              ),
              const Divider(),
              const SizedBox(
                height: 13,
              ),
              Text(AppLocalizations.of(context)!.settings, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 1,
                child: ListView.builder(itemCount: list.length, itemBuilder: (context,index){
                  return  Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 10),
                    child: ListTile(
                      onTap: (){

                        switch(index){
                          case 0:
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LanguageSelectionScreen()));
                          case 1:
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const ThemeModeScreen()));
                          case 2:
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const PrivacyPolicyScreen()));
                          case 3:
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const ContactScreen()));
                          case 4:
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>const AboutUsScreen()));
                            showAboutDialog(context: context, applicationName: 'DIGIVOTE',applicationVersion: 'FYP-FALL-2024 1.0 Release',applicationIcon: Image.asset( 'assets/images/logo.png',width: 40,), children: [Text("This application is a registered trademark for android, copying this could lead to a serious action.",textAlign: TextAlign.justify,)]);
                          case 5:

                            alertDialog(context: context,dismissible: false, title: AppLocalizations.of(context)!.logout, content:AppLocalizations.of(context)!.want_to_Logout,actions: [TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text(AppLocalizations.of(context)!.cancel)), TextButton(onPressed: ()async{

                              SharedPreferences sp = await SharedPreferences.getInstance();
                              sp.remove('token');
                              sp.remove('officialToken');

                              authProvider.setLoggedIn(auth: false);


                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));

                            }, child: Text(AppLocalizations.of(context)!.confirm, style: const TextStyle(color: Colors.red)))]);




                        }


                      },
                      contentPadding: const EdgeInsets.all(0),
                      splashColor: const Color(0XFFdff7dc),
                      selectedTileColor: Colors.green ,
                      leading: CircleAvatar(
                        backgroundColor: primaryColor,
                        child: Icon(list[index]['icon'], color: whiteColor,),
                      ),
                      title: Text(list[index]['title'], style: const TextStyle(fontWeight: FontWeight.w500),),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  );
                }),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
