
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/button.dart';
import 'package:fyp/utils/app_colors.dart';
import 'package:fyp/utils/constants.dart';
import 'package:fyp/view/official_view/change_password_screen.dart';
import 'package:fyp/view/official_view/dummy_screen.dart';
import 'package:fyp/view/official_view/news_announcements_screen.dart';
import 'package:fyp/view/official_view/official_candidates_screen.dart';
import 'package:fyp/view/official_view/official_events_history.dart';
import 'package:fyp/view/official_view/official_profile_screen.dart';
import 'package:fyp/view/official_view/register_candidate_screen.dart';
import 'package:fyp/view/result_screen.dart';
import 'package:fyp/view/results_screen.dart';
import 'package:fyp/view/setting_screen.dart';
import 'package:fyp/view/upcoming_event_screen.dart';
import 'package:fyp/view_model/announcement_provider.dart';
import 'package:fyp/view_model/counter_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OfficialDashboard extends StatefulWidget {
  const OfficialDashboard({super.key});

  @override
  State<OfficialDashboard> createState() => _OfficialDashboardState();
}

class _OfficialDashboardState extends State<OfficialDashboard> {

  bool isLoading = false;
  int selectedIndex = 0;
  bool isPressed = false;
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

  @override
  void initState() {

    getById();



    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    final announcementProvider = Provider.of<AnnouncementProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Stack(
                  children:[

                    Container(
                      width: double.infinity,
                      height:150,
                      decoration: BoxDecoration(
                          color:const Color(0xffe0fcdc),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [





                                Text(AppLocalizations.of(context)!.dashboard,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                                const SizedBox(height: 10),
                                CircleAvatar(
                                    radius: 33,
                                    backgroundColor:primaryColor,

                                    child:splitImage != null ? Image.memory( base64Decode(splitImage![splitImage!.length-1]),width: 40,height: 40,) : const CupertinoActivityIndicator()
                                )


                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [



                                  // InkWell( onTap: (){        Navigator.push(context, MaterialPageRoute(builder: (context)=> const ChangePasswordScreen()));}, child: Text('Open Dapp')),
                                  Text(AppLocalizations.of(context)!.hi_welcome,style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500,color: primaryColor), ),
                                  Text("${user != null ? user['name'].toString() : 'Loading...'}",textAlign: TextAlign.center, style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500,color: primaryColor),)],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    const Center(child: Image(height: 150, image: AssetImage('assets/images/vote.png'),opacity: AlwaysStoppedAnimation(.2),)),
                  ]
              ),
              const SizedBox(height: 5,),
              // Material(
              //   elevation: 10,
              //   borderRadius: BorderRadius.circular(10),
              //   child: Container(
              //     width: double.infinity,
              //     height: 200,
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //         borderRadius: BorderRadius.circular(10)
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(10.0),
              //       child: Column(
              //         children: [
              //
              //           Expanded(
              //             child: GridView.builder(itemCount: 1, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemBuilder: (context,item){
              //               return Padding(
              //                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              //                 child: Container(
              //
              //
              //                   decoration: BoxDecoration(
              //                       color: Colors.greenAccent,
              //                       borderRadius: BorderRadius.circular(10)
              //                   ),
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(10.0),
              //                     child: Column(
              //                       mainAxisAlignment: MainAxisAlignment.center,
              //                       crossAxisAlignment: CrossAxisAlignment.center,
              //                       children: [
              //                         SizedBox(height: 10,),
              //                         Center(child: Text('Register Candidate', textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w500),))
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               );
              //             }),
              //           )
              //
              //
              //
              //
              //
              //         ],
              //       ),
              //     ),
              //   ),
              // ),

              const SizedBox(height: 15,),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const OfficialCandidatesScreen() ));
                    },
                    customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                    ),
                    splashColor: Colors.tealAccent,
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 160,
                        height: MediaQuery.of(context).size.height * 0.17,
                        decoration: BoxDecoration(
                            color: Colors.tealAccent,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:  Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(child: Text(AppLocalizations.of(context)!.view_candidates,textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white),)),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const RegisterCandidateScreen() ));
                    },
                    customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                    ),
                    splashColor: Colors.blue,
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 200,
                        height: MediaQuery.of(context).size.height * 0.17,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:  Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(child: Text(AppLocalizations.of(context)!.register_candidate,textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white),)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const OfficialEventsHistory()));
                    },
                    customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                    ),
                    splashColor: Colors.deepPurple,
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 200,
                        height: MediaQuery.of(context).size.height * 0.17,
                        decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(child: Text(AppLocalizations.of(context)!.party_events,textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white),)),
                        ),
                      ),
                    ),
                  ),


                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const ResultsScreen()));
                    },
                    customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                    ),
                    splashColor: Colors.teal,
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 160,
                        height: MediaQuery.of(context).size.height * 0.17,
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:  Padding(
                          padding:EdgeInsets.all(8.0),
                          child: Center(child: Text(AppLocalizations.of(context)!.results,textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white),)),
                        ),
                      ),
                    ),
                  )
                ],
              )

              ,const SizedBox(height: 15,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.news_updates,style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> NewsAnnouncementsScreen()));
                    },
                    splashColor: Colors.green,
                    radius: 2,
                    child: Container(
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: Icon(Icons.arrow_right_sharp, size: 25, color: Colors.white,)),
                  )
                ],
              ),

              const SizedBox(height: 8,),

              // Expanded(
              //
              //   child: ListView.builder(scrollDirection: Axis.vertical, itemCount: news.length, itemBuilder: (context,index){
              //     return InkWell(
              //       radius: 20,
              //       onTap: () async{
              //         print(index);
              //         selectedIndex = index;
              //         if(isPressed == true && selectedIndex != index){
              //           setState(() {
              //             isPressed = false;
              //           });
              //           return;
              //         }
              //
              //         isPressed = true;
              //         setState(() {});
              //         await Future.delayed(const Duration(seconds: 5));
              //         setState(() {
              //           isPressed = false;
              //         });
              //       },
              //       child: Padding(
              //         padding: const EdgeInsets.only(top: 8.0, right: 5),
              //         child: SizedBox(
              //           width: MediaQuery.of(context).size.width * 0.89,
              //
              //           child: Stack(
              //             alignment: AlignmentDirectional.topEnd,
              //             children: [
              //
              //
              //
              //               ClipRRect(
              //                   borderRadius: BorderRadius.circular(10),
              //                   child: Image(height: 120,width: double.infinity , image: AssetImage('assets/images/${news[index]['image'].toString()}',), fit: BoxFit.fill, opacity: AlwaysStoppedAnimation(.3),)),
              //               Container(
              //
              //                 height: 120,
              //                 decoration: BoxDecoration(
              //                     color: Colors.black12,
              //                     borderRadius: BorderRadius.circular(10)
              //                 ),
              //                 child:  Padding(
              //                   padding: const EdgeInsets.all(15.0),
              //                   child: Column(
              //                     mainAxisAlignment: MainAxisAlignment.end,
              //                     children: [
              //                       Text(news[index]['title'].toString(), style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 16),)
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //
              //
              //               if(isPressed == true && index == selectedIndex)
              //                 Padding(
              //                   padding: const EdgeInsets.symmetric(horizontal: 5.0),
              //                   child: ElevatedButton( onPressed: (){
              //                     setState(() {
              //                       isPressed = false;
              //                     });
              //                     Navigator.push(context, MaterialPageRoute(builder: (context)=> OfficialProfileScreen(id: user['_id'].toString(),name: user['name'].toString(),email: user['email'].toString(),description: user['description'].toString(),password: user['password'].toString(),image: splitImage != null ? splitImage![splitImage!.length - 1] : null,)));
              //                   }, style: ElevatedButton.styleFrom(backgroundColor: primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),child: const Text("View Details", style: TextStyle(color: Colors.white),)),
              //                 ),
              //
              //
              //             ],
              //           ),
              //         ),
              //       ),
              //     );
              //   }),
              // )


              Expanded(

                child: FutureBuilder(
                  future: announcementProvider.getPost(),
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      return const Center(child: const CircularProgressIndicator());
                    }
                    else if(snapshot.hasError){
                      return Text('Something went wrong');
                    }
                    else {
                      return ListView.builder(scrollDirection: Axis.vertical,
                          itemCount: announcementProvider.postList.length,
                          itemBuilder: (context, index) {
                            return
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    width: double.infinity,
                                    height: 145,
                                    decoration: BoxDecoration(
                                        color: Colors.white,

                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(100))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 8.0, right: 8, left: 3.5, top: 3.5),
                                            child: Icon(Icons.star, color: Colors.white, size: 18,),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric( horizontal: 12.0, vertical: 4),
                                          child: Column(
                                            children: [
                                              // Text('${'Every one talks more realistic says president, visit to Pakistan. Peace talks more realistic says president, visit to Pakistan'.substring(0, 100)}.... ', textAlign: TextAlign.justify , style: TextStyle(fontWeight: FontWeight.w500),),
                                              Text('${announcementProvider.postList[index]['content']?.split(' ').take(15).join(' ') ?? ''}...', textAlign: TextAlign.justify , style: TextStyle(fontWeight: FontWeight.w500),),

                                              Padding(
                                                padding: const EdgeInsets.only(top: 8.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(  DateFormat('dd MMMM yyyy').format(DateTime.parse(announcementProvider.postList[index]['date'].toString())), style: TextStyle(color: Colors.black54),),

                                                    // InkWell(
                                                    //   onTap: (){
                                                    //
                                                    //   },
                                                    //   child: Row(
                                                    //     children: [
                                                    //       Icon(Icons.attachment),
                                                    //       SizedBox(width: 4,),
                                                    //       Text('img.jpg', style: TextStyle(color: primaryColor, fontStyle: FontStyle.italic),)
                                                    //     ],
                                                    //   ),
                                                    // )

                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                          });
                    }

                  },

                ),
              )

            ],
          ),
        ),
      ),


    );
  }
}
