


import 'package:flutter/material.dart';
import 'package:fyp/components/custom_app_bar.dart';
import 'package:fyp/utils/app_colors.dart';
import 'package:fyp/view/result_screen.dart';
import 'package:fyp/view_model/election_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  @override
  Widget build(BuildContext context) {
    final electionProvider =  Provider.of<ElectionProvider>(context);
    return Scaffold(
      appBar: customAppBar(title: AppLocalizations.of(context)!.results,context: context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Expanded(
                child: FutureBuilder(future: electionProvider.getElections() , builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator(),);
                  }else if(snapshot.hasError){
                    return const Center(child: Text('Something went wrong'),);
                  }
                  else{
                    return ListView.builder(
                      itemCount: electionProvider.elections.length,
                      itemBuilder: (context, index) {
                        final elections = electionProvider.elections[index];
                        return
                          InkWell(
                            onTap: (){


                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ResultScreen(id: elections.id!, title: elections.title.toString(), date: DateFormat("dd MMMM yyyy").format(DateTime.parse(elections.startDate.toString()),), startTime: DateFormat('h:mm a').format(DateTime.parse(elections.startDate.toString())), endTime: DateFormat('h:mm a').format(DateTime.parse(elections.endDate.toString())))));




                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: double.infinity,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: primaryColor, width: 1.5),
                                    color: primaryColor
                                    // color: Color. //Color(0xffe0fcdc)
                                    // color: Color(0XFFf7faf7)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        if(elections.status == 'completed')
                                          Row(
                                            children: [
                                              Container(
                                                width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: Colors.lightGreen,
                                                    borderRadius: BorderRadius.circular(50)
                                                                                ),
                                                  child: Icon(Icons.done_all, color: Colors.white,)),
                                              SizedBox(width: 5,)
                                            ],
                                          ),

                                        Text('${elections.title ?? ''} ${DateFormat('yyyy').format(DateTime.parse(elections.startDate.toString()))}', style: TextStyle(overflow: TextOverflow.ellipsis,fontSize: 20,fontStyle: FontStyle.italic, fontWeight: FontWeight.w500, color: Colors.white),),
                                     //   Text(elections.status ?? '', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );

                      },
                    );
                  }

                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
