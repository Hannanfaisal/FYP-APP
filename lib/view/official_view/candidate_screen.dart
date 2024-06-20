
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp/components/custom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CandidateScreen extends StatefulWidget {
  const CandidateScreen({super.key, required this.name, required this.photo, required this.phone, required this.email, required this.age, required this.gender});

  final String name;
  final String email;
  final String phone;
  final String photo;
  // final String electedAs;
  final String age;
  final String gender;

  @override
  State<CandidateScreen> createState() => _CandidateScreenState();
}

class _CandidateScreenState extends State<CandidateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: widget.name),
      body: SafeArea(child: 
      Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Material(
                elevation: 10,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,

                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                              width: 100,
                              height: 100,

                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Image.memory(base64Decode(widget.photo), fit: BoxFit.fitHeight,) ),
                        ),

                        const SizedBox(height: 7,),

                        Text(widget.name, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),

                        const SizedBox(height: 7,),
                        Row(
                          
                          children: [
                            Expanded(child: Text("${AppLocalizations.of(context)!.email}: ", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),)),
                            Expanded(flex:3, child: Text(widget.email, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black54),)),
                          ],
                        ),

                        const SizedBox(height: 7,)
,
                        Row(
                          children: [
                            Expanded(child: Text("${AppLocalizations.of(context)!.phone}: ", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),)),
                            Expanded(flex: 3, child: Text(widget.phone, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black54),)),
                          ],
                        ),

                        const SizedBox(height: 7,)
                        ,
                        Row(
                          children: [
                            Expanded(child: Text("${AppLocalizations.of(context)!.gender}: ", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),)),
                            Expanded(flex: 3,child: Text(widget.gender, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black54),)),
                          ],
                        ),

                        const SizedBox(height: 7,)
                        ,
                        Row(
                          children: [
                            Expanded(child: Text("${AppLocalizations.of(context)!.age}: ", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),)),
                            Expanded(flex: 3,child: Text(widget.age, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black54),)),
                          ],
                        ),


                        const SizedBox(height: 7,),

                        Row(
                          children: [
                            Expanded(child: Text("${AppLocalizations.of(context)!.elected_as}: ", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),)),
                            Expanded(flex: 3,child: Text('Not Elected Yet', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black54),)),
                          ],
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            )
            
          ],
        ),
      )
      ),
    );
  }
}
