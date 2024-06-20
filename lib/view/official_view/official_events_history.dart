import 'package:flutter/material.dart';
import 'package:fyp/components/custom_app_bar.dart';
import 'package:fyp/utils/app_colors.dart';
import 'package:fyp/view/official_view/official_dashboard.dart';
import 'package:fyp/view/official_view/official_home_screen.dart';
import 'package:fyp/view_model/election_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OfficialEventsHistory extends StatefulWidget {
  const OfficialEventsHistory({super.key});

  @override
  State<OfficialEventsHistory> createState() => _OfficialEventsHistoryState();
}

class _OfficialEventsHistoryState extends State<OfficialEventsHistory> {


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
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(AppLocalizations.of(context)!.party_events, style: TextStyle(color: Colors.white),),
        leading: IconButton(
        onPressed: (){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> OfficialHomeScreen()), (route) => false);
    },
    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white,),
    ),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [

              Expanded(
                child: FutureBuilder(
                  future: electionProvider.getPartyElections(),
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
                        itemCount: electionProvider.partyElections.length,
                        itemBuilder: (context, index) {

                          final election = electionProvider.partyElections[index];
                          print(election['startDate']);

                            return  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                elevation: 6,
                                borderRadius: BorderRadius.circular(6.0),
                                child: Container(
                                  width: double.infinity,
                                  height:  145,
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
                                          election['title']?? '',
                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          'Start Date: ${formatDate(election['startDate']) ?? ''} ${formatTime(election['startDate'])}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          'End Date: ${ formatDate(election['endDate'] ?? '')} ${formatTime(election['endDate'] ?? '')} ',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          'Status: ${election['status']?.toUpperCase() ?? ''}',
                                          style:  TextStyle(
                                            fontSize: 16,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.grey.shade600,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),




                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );



                          }


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

