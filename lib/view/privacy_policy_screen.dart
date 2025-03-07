import 'package:flutter/material.dart';
import 'package:fyp/components/custom_app_bar.dart';
import 'package:fyp/utils/app_colors.dart';




class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: customAppBar(title: 'Privacy Policy',context: context),
      body:  SingleChildScrollView(
        child:  SafeArea(
          child: Padding(
            padding: EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Privacy Policy", style: TextStyle(fontSize:24,fontWeight: FontWeight.w700),),
                Text("Abdul Hannan Faisal, Arslan Waheed, Mudasir Zulfiqar built the DIGIVOTE app as a Final Year Project. This SERVICE is provided at no cost and is intended for use as is. This page is used to inform visitors regarding our policies with the use and disclosure of Personal Information if anyone decided to use my Service. If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy. The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at DIGIVOTE unless otherwise defined in this Privacy Policy.", textAlign: TextAlign.justify, style: TextStyle( fontSize:16,fontWeight: FontWeight.w400),),
                SizedBox(height: 8,),
                Text("Information Collection and Use", style: TextStyle(fontSize:24,fontWeight: FontWeight.w600),),
                Text("For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information. The information that I request will be retained on your device and is not collected by me in any way.", textAlign: TextAlign.justify, style: TextStyle( fontSize:16,fontWeight: FontWeight.w400))
                ,SizedBox(height: 8,),
                Text("Security", style: TextStyle(fontSize:24,fontWeight: FontWeight.w600),),
                Text("We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.", textAlign: TextAlign.justify, style: TextStyle( fontSize:16,fontWeight: FontWeight.w400))
                ,SizedBox(height: 8,),
                Text("Changes to Privacy Policy", style: TextStyle(fontSize:24,fontWeight: FontWeight.w600),),
                Text("We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.",textAlign: TextAlign.justify, style: TextStyle( fontSize:16,fontWeight: FontWeight.w400)),
                SizedBox(height: 8,),
                Text("Contact Us", style: TextStyle(fontSize:24,fontWeight: FontWeight.w600),),
                RichText(textAlign: TextAlign.justify,text: TextSpan(
                  text: 'In case of any query, questions or suggestions about our privacy concerns, please do not hesitate to contact us at ',
                  style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400, height: 1.4),
                  children: [
                    TextSpan(
                      text: '70110843@student.uol.edu.pk.',
                      style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 20 ),
                    )
                  ]
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
