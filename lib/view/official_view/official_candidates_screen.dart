import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp/components/custom_app_bar.dart';
import 'package:fyp/components/label_input_field.dart';
import 'package:fyp/utils/app_colors.dart';
import 'package:fyp/view/official_view/candidate_screen.dart';
import 'package:fyp/view_model/candidate_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OfficialCandidatesScreen extends StatefulWidget {
  const OfficialCandidatesScreen({super.key});

  @override
  State<OfficialCandidatesScreen> createState() =>
      _OfficialCandidatesScreenState();
}

class _OfficialCandidatesScreenState extends State<OfficialCandidatesScreen> {
  TextEditingController searchController = TextEditingController();
  String search = '';
  List<Map<String, String>> candidates = [
    {
      'name': 'Abdul Hannan Faisal',
      'image': 'candidate.jpg',
      'position': 'President',
      'party': 'National Party'
    },
    {
      'name': 'Arslan Waheed',
      'image': 'candidate2.jpg',
      'position': 'Prime Minister',
      'party': 'National Party'
    },
    {
      'name': 'Hannan Faisal',
      'image': 'candidate3.jpg',
      'position': 'President',
      'party': 'National Party'
    },
    {
      'name': 'Mudasir Zulfiqar',
      'image': 'candidate4.jpg',
      'position': 'Minister',
      'party': 'National Party'
    }
  ];

  @override
  Widget build(BuildContext context) {
    final candidateProvider = Provider.of<CandidateProvider>(context);
    return Scaffold(
      appBar: customAppBar(
          title: AppLocalizations.of(context)!.view_candidates,
          context: context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelInputField(
                label: AppLocalizations.of(context)!.search,
                controller: searchController,
                icon: const Icon(Icons.search),
                borderRadius: 10,
    onChange: (value) {
      setState(() {
        search = value.toString();
      });
    }),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(AppLocalizations.of(context)!.view_candidates,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: FutureBuilder(
                    future: candidateProvider.getCandidatesByParty(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        return ListView.builder(
                            itemCount:
                                candidateProvider.candidatesByParty.length,
                            itemBuilder: (context, index) {
                              final candidates =
                                  candidateProvider.candidatesByParty[index];

                              final name = candidates.name ?? '';
                              print(name);
                              if ( searchController.text.isEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 12.0, left: 8, right: 8),
                                  child: Container(
                                      width: double.infinity,
                                      height: 85,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.grey, width: 2)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(8),
                                                        bottomLeft:
                                                            Radius.circular(8)),
                                                child: Container(
                                                    width: 90,
                                                    height: 85,
                                                    decoration:
                                                        const BoxDecoration(
                                                            color:
                                                                Colors.black12),
                                                    child: Image.memory(
                                                        base64Decode(candidates
                                                            .photo
                                                            .toString()))),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          candidates.name ?? '',
                                                          style: const TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),

                                                        // Text( candidates.party?.name ?? '', style:
                                                        // const TextStyle(fontSize: 15,
                                                        //     fontWeight: FontWeight
                                                        //         .w400),),

                                                        // Text(
                                                        //   candidates.position ?? '', style:
                                                        // const TextStyle(fontSize: 15,
                                                        //     fontWeight: FontWeight.w400,
                                                        //     color: Colors.black54),),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            // crossAxisAlignment: CrossAxisAlignment.end,

                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => CandidateScreen(
                                                              name: candidates
                                                                  .name
                                                                  .toString(),
                                                              photo: candidates
                                                                  .photo
                                                                  .toString(),
                                                              email: candidates
                                                                  .email
                                                                  .toString(),
                                                              phone: candidates
                                                                  .phone
                                                                  .toString(),
                                                              age: candidates
                                                                  .age
                                                                  .toString(),
                                                              gender: candidates
                                                                  .gender
                                                                  .toString())));
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10.0),
                                                  child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                          color: primaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50)),
                                                      child: Icon(
                                                        Icons
                                                            .arrow_right_outlined,
                                                        color: Colors.white,
                                                        size: 30,
                                                      )),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      )),
                                );
                              }
                              else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 12.0, left: 8, right: 8),
                                  child: Container(
                                      width: double.infinity,
                                      height: 85,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.grey, width: 2)),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                    Radius.circular(8),
                                                    bottomLeft:
                                                    Radius.circular(8)),
                                                child: Container(
                                                    width: 90,
                                                    height: 85,
                                                    decoration:
                                                    const BoxDecoration(
                                                        color:
                                                        Colors.black12),
                                                    child: Image.memory(
                                                        base64Decode(candidates
                                                            .photo
                                                            .toString()))),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          candidates.name ?? '',
                                                          style: const TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500),
                                                        ),

                                                        // Text( candidates.party?.name ?? '', style:
                                                        // const TextStyle(fontSize: 15,
                                                        //     fontWeight: FontWeight
                                                        //         .w400),),

                                                        // Text(
                                                        //   candidates.position ?? '', style:
                                                        // const TextStyle(fontSize: 15,
                                                        //     fontWeight: FontWeight.w400,
                                                        //     color: Colors.black54),),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            // crossAxisAlignment: CrossAxisAlignment.end,

                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => CandidateScreen(
                                                              name: candidates
                                                                  .name
                                                                  .toString(),
                                                              photo: candidates
                                                                  .photo
                                                                  .toString(),
                                                              email: candidates
                                                                  .email
                                                                  .toString(),
                                                              phone: candidates
                                                                  .phone
                                                                  .toString(),
                                                              age: candidates
                                                                  .age
                                                                  .toString(),
                                                              gender: candidates
                                                                  .gender
                                                                  .toString())));
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10.0),
                                                  child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                          color: primaryColor,
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              50)),
                                                      child: Icon(
                                                        Icons
                                                            .arrow_right_outlined,
                                                        color: Colors.white,
                                                        size: 30,
                                                      )),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      )),
                                );
                              }
                            });
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
