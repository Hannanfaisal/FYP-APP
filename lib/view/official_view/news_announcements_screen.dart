import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp/components/custom_app_bar.dart';
import 'package:fyp/components/label_input_field.dart';
import 'package:fyp/models/announcements_model.dart';
import 'package:fyp/utils/app_colors.dart';
import 'package:fyp/view_model/announcement_provider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class model{
  String title;
  String content;
  model({required this.title, required this.content});
}


class NewsAnnouncementsScreen extends StatefulWidget {
  const NewsAnnouncementsScreen({super.key});



  @override
  State<NewsAnnouncementsScreen> createState() => _NewsAnnouncementsScreenState();
}

class _NewsAnnouncementsScreenState extends State<NewsAnnouncementsScreen> {



  DateTime date = DateTime.now();
  TextEditingController searchController = TextEditingController();

  String search = '';






  @override
  Widget build(BuildContext context) {

   final announcementProvider = Provider.of<AnnouncementProvider>(context);

    return Scaffold(
    appBar: customAppBar(title: 'Announcements', context: context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [

              LabelInputField(label: 'Search', controller: searchController, icon: const Icon(Icons.search), borderRadius: 10,onChange: (value){
                setState(() {
                  search = value.toString();
                });


              },),

              // Text('${date.weekday}-${date.month}-${date.year}'),






              const SizedBox(height: 15,),



              Expanded(

                child: FutureBuilder(future: announcementProvider.getPost() , builder: (context, snapshot){

                  // if(snapshot.connectionState == ConnectionState.waiting){
                  //   return const Center(child: CircularProgressIndicator());
                  // }
                   if(snapshot.hasData){
                    return const Center(child: Text('no data'));
                  }
                  else if(snapshot.hasError){
                    return const Center(child:Text("Something went wrong"));
                  }
                  else {
                    return ListView.builder(scrollDirection: Axis.vertical, itemCount: announcementProvider.postList.length, itemBuilder: (context,index) {
                      String name = announcementProvider
                          .postList[index]['content'] ?? '';
                      if (index < announcementProvider.postList.length &&
                          searchController.text.isEmpty) {
                        return InkWell(
                          radius: 20,
                          onTap: () {


                            showBottomSheet(context: context,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                constraints: BoxConstraints(
                                    maxHeight: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 1),
                                builder: (context) {
                                  return Container(
                                    decoration: BoxDecoration(

                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30))
                                    ),
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Center(child: Icon(Icons
                                                .arrow_drop_down_circle_outlined)),
                                            Text(announcementProvider
                                                .postList[index]['title'] ?? '',
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight
                                                      .w500),),
                                            const SizedBox(height: 5,),
                                            Text(announcementProvider
                                                .postList[index]['content'] ?? '',
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(fontSize: 16,),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Padding(
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
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(100))
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 8.0,
                                            right: 8,
                                            left: 3.5,
                                            top: 3.5),
                                        child: Icon(
                                          Icons.star, color: Colors.white,
                                          size: 18,),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 4),
                                      child: Column(
                                        children: [

                                          Text('${announcementProvider.postList[index]['content']?.split(' ').take(15).join(' ')}',
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500 ,color: Colors.black),),

                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text(DateFormat('dd MMMM yyyy')
                                                    .format(DateTime.parse(
                                                    announcementProvider
                                                        .postList[index]['date'])),
                                                  style: TextStyle(
                                                      color: Colors.black54),),

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
                          ),
                        );
                      }
                      else if (name.toLowerCase().contains(
                          searchController.text.toLowerCase())) {
                        return InkWell(
                          radius: 20,
                          onTap: () {


                            showBottomSheet(context: context,
                                backgroundColor: Colors.white,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                constraints: BoxConstraints(
                                    maxHeight: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 1),
                                builder: (context) {
                                  return SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(25.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [

                                          Text(announcementProvider
                                              .postList[index]['title'] ?? '',
                                            style: const TextStyle(fontSize: 18,
                                                fontWeight: FontWeight.w500, ),),

                                          Text(
                                            name, textAlign: TextAlign.justify,
                                            style: TextStyle(fontSize: 16, ),)
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Padding(
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
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(100))
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 8.0,
                                            right: 8,
                                            left: 3.5,
                                            top: 3.5),
                                        child: Icon(
                                          Icons.star, color: Colors.white,
                                          size: 18,),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 4),
                                      child: Column(
                                        children: [

                                          Text('${announcementProvider.postList[index]['content']?.split(' ').take(15).join(' ')}',
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500, color: Colors.black),),

                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text(DateFormat('dd MMMM yyyy')
                                                    .format(DateTime.parse(
                                                    announcementProvider
                                                        .postList[index]['date']
                                                        .toString())),
                                                  style: TextStyle(
                                                      color: Colors.black54),),

                                                // InkWell(
                                                //   onTap: () {
                                                //
                                                //   },
                                                //   child: Row(
                                                //     children: [
                                                //       Icon(Icons.attachment),
                                                //       SizedBox(width: 4,),
                                                //       Text('img.jpg',
                                                //         style: TextStyle(
                                                //             color: primaryColor,
                                                //             fontStyle: FontStyle
                                                //                 .italic),)
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
                          ),
                        );
                      }
                    } );
                  }

                },)
              ),

              const SizedBox(height: 20,)
            ],
          ),
        ),
      ),

    );
  }
}
