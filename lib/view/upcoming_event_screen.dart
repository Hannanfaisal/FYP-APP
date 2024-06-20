
import 'package:flutter/material.dart';
import 'package:fyp/components/custom_app_bar.dart';
import 'package:fyp/models/elections_model.dart';
import 'package:fyp/utils/app_colors.dart';
import 'package:fyp/view/election_screen.dart';
import 'package:fyp/view_model/election_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpcomingEventScreen extends StatefulWidget {
  const UpcomingEventScreen({Key? key}) : super(key: key);

  @override
  State<UpcomingEventScreen> createState() => _UpcomingEventScreenState();
}

class _UpcomingEventScreenState extends State<UpcomingEventScreen> {




  @override
  void initState() {
    super.initState();
    // getElections();
  }



  String formatDate(date){
    DateTime dateTime = DateTime.parse(date);
    DateTime dateTimeInPKT = dateTime.add(Duration(hours: 5));

    String formattedDate = DateFormat('d MMMM yyyy').format(dateTimeInPKT);
    return formattedDate;
  }

  String formatTime(date){
    DateTime dateTime = DateTime.parse(date);
    DateTime dateTimeInPKT = dateTime.add(Duration(hours: 5));
    String formattedTime = DateFormat().add_jm().format(dateTimeInPKT);
    return formattedTime;
    
  }

  @override
  Widget build(BuildContext context) {
    final electionProvider = Provider.of<ElectionProvider>(context);
    return Scaffold(
      appBar: customAppBar(title: AppLocalizations.of(context)!.upcoming_events, context: context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [

              Expanded(
                child: FutureBuilder(
                  future: electionProvider.getElections(),
                  builder: (context, snapshot) {
                    // if(!snapshot.hasData){
                    //   return Text("No data");
                    // }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return ListView.builder(
                        itemCount: electionProvider.elections.length,
                        itemBuilder: (context, index) {

                          final election = electionProvider.elections[index];
                          print("Election: ${election.status}");
                          print(formatDate(election.startDate));
                          print(DateFormat('d MMMM yyyy').format(DateTime.parse( DateTime.now().toString())));
                          if(election.status == 'not started'){
                            return  Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Material(
                                  elevation: 6,
                                  borderRadius: BorderRadius.circular(6.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: formatDate(election.startDate) == DateFormat('d MMMM yyyy').format(DateTime.parse( DateTime.now().toString())) ? 180 : 145,// 145,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //
                                          // Expanded(
                                          //   child: ListView.builder(  itemCount: election.candidates!.length,  itemBuilder: (context,index){
                                          //     return Text(election.candidates![index].toString());
                                          //   }),
                                          // ),


                                          Text(
                                            election.title ?? '',
                                            style: const TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            'Start Date: ${formatDate(election.startDate) ?? ''} ${formatTime(election.startDate)}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                                color: Colors.black
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            'End Date: ${ formatDate(election.endDate ?? '')} ${formatTime(election.endDate ?? '')} ',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                                color: Colors.black
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            'Status: ${election.status?.toUpperCase() ?? ''}',
                                            style:  TextStyle(
                                              fontSize: 16,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),



                                         if(formatDate(election.startDate) == DateFormat('d MMMM yyyy').format(DateTime.parse( DateTime.now().toString())))
                                    InkWell(
                                    onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ElectionScreen(electionId: election.id,title:election.title.toString(),year: DateFormat('yyyy').format(DateTime.parse(election.startDate ?? '')) , startDate: formatDate(election.startDate), startTime: formatTime(election.startDate), endTime: formatTime(election.endDate), status: election.status.toString(),candidates: election.candidates as List<Candidates> )));
                            },
                              child: Container(width: double.infinity, decoration: BoxDecoration(color: primaryColor), child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Center(child: Text("Start", style: TextStyle(color: Colors.white),)),
                              ))
                                    )

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );

                          }
                          else{
                            return Container(
                            );
                          }

                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

