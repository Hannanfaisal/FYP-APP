//
//
//
// import 'package:flutter/material.dart';
// import 'package:fyp/components/custom_app_bar.dart';
// import 'package:fyp/utils/app_colors.dart';
// import 'package:fyp/view_model/vote_provider.dart';
// import 'package:fyp/view_model/voter_provider.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
//
// class ResultScreen extends StatefulWidget {
//   const ResultScreen({
//     Key? key,
//     required this.id,
//     required this.title,
//     required this.date,
//     required this.startTime,
//     required this.endTime,
//   }) : super(key: key);
//
//   final String id;
//   final String title;
//   final String date;
//   final String startTime;
//   final String endTime;
//
//   @override
//   State<ResultScreen> createState() => _ResultScreenState();
// }
//
// class _ResultScreenState extends State<ResultScreen> {
//   late TooltipBehavior _tooltipBehavior;
//
//
//   @override
//   void initState() {
//     super.initState();
//     _tooltipBehavior = TooltipBehavior(enable: true);
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<VoteProvider>(context, listen: false).resultList(electionId: widget.id);
//     });
//
//   }
//   List<Result> data = [
//     Result(name:'Hannan Faisal',votes: 5000),
//     Result(name:'Arslan Waheed',votes: 3000),
//     Result(name: 'Mudasir Zulfiqar', votes: 1000),
//   ];
//
//
//   bool declared = false;
//
//   void declare() {
//     String formattedDate = DateFormat('d MMMM yyyy', 'en_US').format(
//         DateTime.now());
//     String formattedTime = DateFormat('h:mm a').format(DateTime.now());
//
//     DateTime currentTime = DateFormat('h:mm a').parse(formattedTime);
//
//
//
//     if (currentTime.isAfter(DateFormat('h:mm a').parse(widget.endTime))) {
//
//       declared = true;
//       setState(() {
//
//       });
//     }
//     else {
//
//       declared = false;
//       setState(() {
//
//       });
//
//
//     }
//   }
//
//
//
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     final voteProvider = Provider.of<VoteProvider>(context);
//     final voterProvider = Provider.of<VoterProvider>(context);
//     setState(() {
//       declare();
//     });
//     return Scaffold(
//       appBar: customAppBar(context: context, title: widget.title),
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(22.0),
//             child: Column(
//               children: [
//                 Material(
//                   borderRadius: BorderRadius.circular(5),
//                   elevation: 4,
//                   child: Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text("Date:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
//                               Text(widget.date, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.black54)),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text("Time:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
//                               Text("${widget.startTime} to ${widget.endTime}", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.black54)),
//                             ],
//                           ),
//                           FutureBuilder(
//                             future: voterProvider.getVoters(),
//                             builder: (context, snapshot) {
//                               return Row(
//                                   mainAxisAlignment: MainAxisAlignment
//                                       .spaceBetween,
//                                   children: [
//                                   Text("Total Voters:", style: TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 17)),
//                               Text(voterProvider.voters.toString(), style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.black54)),
//                               ],
//                               );
//                               }
//                           ),
//                           FutureBuilder(
//                             future: voteProvider.totalVotes(electionId: widget.id),
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState == ConnectionState.waiting) {
//                                 return const CircularProgressIndicator();
//                               } else if (snapshot.hasError) {
//                                 return Text("Error: ${snapshot.error}");
//                               } else {
//                                 return Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text("Total vote casted:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
//                                     Text(voteProvider.count.toString(), style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.black54)),
//                                   ],
//                                 );
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextButton(
//                   onPressed: () {
//                     voteProvider.resultList(electionId: widget.id);
//                   },
//                   child: const Text("Press"),
//                 ),
//                 Material(
//                   borderRadius: BorderRadius.circular(5),
//                   elevation: 4,
//                   child: Container(
//                     width: double.infinity,
//                     height: MediaQuery.of(context).size.height * 0.5,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 25.0),
//                       child: Column(
//                         children: [
//                           const Text('Result Analytics', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20)),
//                           const SizedBox(height: 15),
//                           SizedBox(
//                             height: 300,
//                             child: SfCartesianChart(
//                               zoomPanBehavior: ZoomPanBehavior(enablePinching: true, enablePanning: true),
//                               plotAreaBorderWidth: 0,
//                               enableAxisAnimation: true,
//                               tooltipBehavior: _tooltipBehavior,
//                               series: [
//                                 BarSeries<Result, String>(
//                                   name: 'Votes',
//                                   dataSource: voteProvider.result,
//                                   xValueMapper: (Result r, _) => r.name,
//                                   yValueMapper: (Result r, _) => r.votes,
//                                   dataLabelSettings: DataLabelSettings(isVisible: true),
//                                   color: primaryColor,
//                                   enableTooltip: true,
//                                 ),
//                               ],
//                               primaryYAxis: CategoryAxis(isVisible: false, majorGridLines: MajorGridLines(width: 0)),
//                               primaryXAxis: CategoryAxis(majorGridLines: MajorGridLines(width: 0)),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//
//
//
//                 FutureBuilder(
//                   future: voteProvider.selectedCandidate(electionId: widget.id),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const CircularProgressIndicator();
//                     } else if (snapshot.hasError) {
//                       return Text("Error: ${snapshot.error}");
//                     } else {
//                       return  Material(
//                         borderRadius: BorderRadius.circular(5),
//                         elevation: 4,
//                         child: Container(
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(15.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text("Elected Candidate:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
//                                 Text( declared ? voteProvider.selected_candidate : "Not elected", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: primaryColor)),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// //
//
// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:fyp/components/custom_app_bar.dart';
// import 'package:fyp/utils/app_colors.dart';
// import 'package:fyp/view_model/vote_provider.dart';
// import 'package:fyp/view_model/voter_provider.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
//
// class ResultScreen extends StatefulWidget {
//   const ResultScreen({
//     Key? key,
//     required this.id,
//     required this.title,
//     required this.date,
//     required this.startTime,
//     required this.endTime,
//   }) : super(key: key);
//
//   final String id;
//   final String title;
//   final String date;
//   final String startTime;
//   final String endTime;
//
//   @override
//   State<ResultScreen> createState() => _ResultScreenState();
// }
//
// class _ResultScreenState extends State<ResultScreen> {
//   late TooltipBehavior _tooltipBehavior;
//   bool declared = false;
//   Timer? _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     _tooltipBehavior = TooltipBehavior(enable: true);
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<VoteProvider>(context, listen: false).resultList(electionId: widget.id);
//       startPollingResults();
//     });
//
//     declare(); // Call declare to set the declared state
//   }
//
//   void declare() {
//     DateTime endTime = DateFormat('h:mm a').parse(widget.endTime);
//     DateTime currentTime = DateTime.now();
//
//     if (currentTime.isAfter(endTime)) {
//       setState(() {
//         declared = true;
//       });
//     }
//   }
//
//   void startPollingResults() {
//     _timer = Timer.periodic(Duration(seconds: 5), (timer) {
//       Provider.of<VoteProvider>(context, listen: false).resultList(electionId: widget.id);
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final voteProvider = Provider.of<VoteProvider>(context);
//     final voterProvider = Provider.of<VoterProvider>(context);
//
//     return Scaffold(
//       appBar: customAppBar(context: context, title: widget.title),
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(22.0),
//             child: Column(
//               children: [
//                 Material(
//                   borderRadius: BorderRadius.circular(5),
//                   elevation: 4,
//                   child: Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text("Date:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
//                               Text(widget.date, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.black54)),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text("Time:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
//                               Text("${widget.startTime} to ${widget.endTime}", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.black54)),
//                             ],
//                           ),
//                           FutureBuilder(
//                             future: voterProvider.getVoters(),
//                             builder: (context, snapshot) {
//                               return Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Text("Total Voters:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
//                                   Text(voterProvider.voters.toString(), style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.black54)),
//                                 ],
//                               );
//                             },
//                           ),
//                           FutureBuilder(
//                             future: voteProvider.totalVotes(electionId: widget.id),
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState == ConnectionState.waiting) {
//                                 return const CircularProgressIndicator();
//                               } else {
//                                 return Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     const Text("Total Votes Cast:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
//                                     Text(voteProvider.count.toString(), style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.black54)),
//                                   ],
//                                 );
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Material(
//                   borderRadius: BorderRadius.circular(5),
//                   elevation: 4,
//                   child: Container(
//                     width: double.infinity,
//                     height: 500,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: declared
//                         ? StreamBuilder<List<Result>>(
//                       stream: voteProvider.resultStream,
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.waiting) {
//                           return Center(child: const CircularProgressIndicator());
//                         } else if (snapshot.hasError) {
//                           return Text("Error: ${snapshot.error}");
//                         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                           return const Text("No results available");
//                         } else {
//                           return
//                             SfCircularChart(
//                               title: ChartTitle(text: "Votes"),
//                               legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
//                               tooltipBehavior: _tooltipBehavior,
//                               series: <CircularSeries>[
//                                 PieSeries<Result, String>(
//                                   dataSource: snapshot.data!,
//                                   xValueMapper: (Result data, _) => data.name,
//                                   yValueMapper: (Result data, _) => data.votes,
//                                   dataLabelSettings: const DataLabelSettings(isVisible: true),
//                                 ),
//                               ],
//                             );
//                           // SizedBox(
//                           //   height: 300,
//                           //   child: SfCartesianChart(
//                           //     zoomPanBehavior: ZoomPanBehavior(enablePinching: true, enablePanning: true),
//                           //     plotAreaBorderWidth: 0,
//                           //     enableAxisAnimation: true,
//                           //     tooltipBehavior: _tooltipBehavior,
//                           //     series: [
//                           //       BarSeries<Result, String>(
//                           //         name: 'Votes',
//                           //         dataSource: snapshot.data!,
//                           //         xValueMapper: (Result r, _) => r.name,
//                           //         yValueMapper: (Result r, _) => r.votes,
//                           //         dataLabelSettings: DataLabelSettings(isVisible: true),
//                           //         color: primaryColor,
//                           //         enableTooltip: true,
//                           //       ),
//                           //     ],
//                           //     primaryYAxis: CategoryAxis(isVisible: false, majorGridLines: MajorGridLines(width: 0)),
//                           //     primaryXAxis: CategoryAxis(majorGridLines: MajorGridLines(width: 0)),
//                           //   ),
//                           // );
//
//                         }
//                       },
//                     )
//                         : const Center(
//                       child: Text("Results will be declared once election ends", style: TextStyle(fontSize: 18)),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
// }
//
//




import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp/components/custom_app_bar.dart';
import 'package:fyp/utils/app_colors.dart';
import 'package:fyp/utils/constants.dart';
import 'package:fyp/view_model/vote_provider.dart';
import 'package:fyp/view_model/voter_provider.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    Key? key,
    required this.id,
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  final String id;
  final String title;
  final String date;
  final String startTime;
  final String endTime;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late TooltipBehavior _tooltipBehavior;
  bool declared = false;
  Timer? _timer;


  List<Result> _result = [];
  List<Result> get result => _result;

  String selected_candidate = "";

  final StreamController<List<Result>> _resultStreamController = StreamController.broadcast();
  Stream<List<Result>> get resultStream => _resultStreamController.stream;


  Future<void> resultList({required String electionId}) async {
    try {
      final response = await http.get(Uri.parse("${androidURL}resultListByElection/$electionId"));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body)['results'];
        if (jsonData is List) {
          List<Result> newResult = jsonData.map<Result>((item) => Result.fromJson(item)).toList();
          if (!_areResultsEqual(_result, newResult)) {
            _result = newResult;
            _resultStreamController.add(_result);

          }

        } else {
          debugPrint('Unexpected data format: $jsonData');
        }
      } else {
        debugPrint(response.statusCode.toString());
        debugPrint(response.reasonPhrase);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  bool _areResultsEqual(List<Result> oldResults, List<Result> newResults) {
    if (oldResults.length != newResults.length) return false;
    for (int i = 0; i < oldResults.length; i++) {
      if (oldResults[i].name != newResults[i].name || oldResults[i].votes != newResults[i].votes) {
        return false;
      }
    }
    return true;
  }


  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _tooltipBehavior = TooltipBehavior(enable: true);

    resultList(electionId: widget.id);

    startPollingResults();
    declare();

    print("Declared: ${declared}");

    // Future.delayed(Duration.zero).then((_) {
    //
    //   Provider.of<VoteProvider>(context, listen: false).resultList(electionId: widget.id);
    //   startPollingResults();
    // });
    // Call declare to set the declared state
  }










  void declare() {
    DateTime endTime = DateFormat('h:mm a').parse(widget.endTime);
    DateTime currentTime = DateFormat('h:mm a').parse(DateFormat('h:mm a').format(DateTime.now()));
    DateTime _currentTime = DateTime.now();
    print(currentTime);
    print(endTime);
    DateTime parsedTime = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse(endTime.toString());


    DateTime newTime = parsedTime.add(Duration(hours: 5));
    print(newTime);
    if (currentTime.isAfter(newTime)) {
      setState(() {
        declared = true;
      });
    }
  }

  void startPollingResults()  {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      resultList(electionId: widget.id);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final voteProvider = Provider.of<VoteProvider>(context);
    final voterProvider = Provider.of<VoterProvider>(context);

    // print(voteProvider.result);
    return Scaffold(
      appBar: customAppBar(context: context, title: widget.title),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              children: [
                Material(
                  borderRadius: BorderRadius.circular(5),
                  elevation: 4,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Date:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                              Text(widget.date, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.black54)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Time:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                              Text("${widget.startTime} to ${widget.endTime}", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.black54)),
                            ],
                          ),
                          FutureBuilder(
                            future: voterProvider.getVoters(),
                            builder: (context,  snapshot) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Total Voters:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                                  Text(voterProvider.voters.toString(), style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.black54)),
                                ],
                              );
                            },
                          ),
                          FutureBuilder(
                            future: voteProvider.totalVotes(electionId: widget.id),
                            builder: (context, snapshot) {
                              print(voteProvider.count);
                              return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Total Votes Cast:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                                        Text(voteProvider.count.toString(), style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.black54)),
                                      ],
                                    );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Material(
                  borderRadius: BorderRadius.circular(5),
                  elevation: 4,
                  child: Container(
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15, right: 5, left: 5),
                      child: Column(
                        children: [
                          const Text('Result Analytics', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20)),
                             const SizedBox(height: 20),
                          StreamBuilder<List<Result>>(
                            stream: resultStream,
                            builder: (context, snapshot) {
                             // print('Data: ${snapshot.data}');
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Text("Error: ${snapshot.error}");
                              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return const Text("No results available");
                              } else {
                                return  SizedBox(
                                  height: 220,
                                  child: SfCartesianChart(
                                    zoomPanBehavior: ZoomPanBehavior(enablePinching: true, enablePanning: true),
                                    plotAreaBorderWidth: 0,
                                    enableAxisAnimation: true,
                                    tooltipBehavior: _tooltipBehavior,
                                    series: [
                                      BarSeries<Result, String>(
                                        name: 'Votes',
                                        dataSource: snapshot.data!,
                                        xValueMapper: (Result data, _) => data.name,
                                        yValueMapper: (Result data, _) => data.votes,
                                        dataLabelSettings: DataLabelSettings(isVisible: true),
                                        color: primaryColor,
                                        enableTooltip: true,
                                      ),
                                    ],
                                    primaryYAxis: CategoryAxis(isVisible: false, majorGridLines: MajorGridLines(width: 0)),
                                    primaryXAxis: CategoryAxis(majorGridLines: MajorGridLines(width: 0)),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),


          const SizedBox(height: 20,),
          Stack(

            children:[


              FutureBuilder(
                    future: voteProvider.selectedCandidate(electionId: widget.id),
                    builder: (context, snapshot) {

                        return  Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 4,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Elected Candidate:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),

                                  Text( declared ? voteProvider.selected_candidate : "Not elected", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: primaryColor)),
                                ],
                              ),
                            ),
                          )
                        );
                      }

                  ),
              declared ? Center(
                child: Lottie.asset('assets/animations/animation_congrat.json', height: 150, fit: BoxFit.fill, width: 250, repeat: false,frameRate: const FrameRate(500)
                ),
              ) : Container(),

            ]
          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class Result {
  final String name;
  final int votes;

  Result({required this.name, required this.votes});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      name: json['name'] ?? '',
      votes: json['value'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'Name: $name, Votes: $votes';
  }

}

