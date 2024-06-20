import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/button.dart';
import 'package:fyp/components/custom_app_bar.dart';
import 'package:fyp/components/label_input_field.dart';
import 'package:fyp/utils/app_colors.dart';
import 'package:fyp/view_model/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});


  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.getProfile().then((_) {
      setState(() {
        if (profileProvider.user != null) {
          nameController.text = profileProvider.user['name'] ?? '';
          ageController.text = profileProvider.user['age'].toString();
          genderController.text = profileProvider.user['gender'] ?? '';
          cityController.text = profileProvider.user['city'] ?? '';
          emailController.text = profileProvider.user['email'] ?? '';
          phoneController.text = profileProvider.user['phone'] ?? '';
        }
      });
    });
  }



  @override
  Widget build(BuildContext context) {
 var profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      appBar: customAppBar(
        title: AppLocalizations.of(context)!.profile,
        context: context

      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child:
             Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children:[



                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 11.0),
                        child: Divider(thickness: 3,color: primaryColor,),
                      ),

                      Container(


                        width: 90,
                        height: 90,


                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: primaryColor
                        ),
                        child:
                        Padding(
                          padding:const  EdgeInsets.all(3.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: FadeInImage.assetNetwork( fit: BoxFit.cover, placeholder: 'assets/images/loading_gif.gif',  image: profileProvider.user?['photo'] ??  'https://img.freepik.com/premium-vector/man-avatar-profile-picture-vector-illustration_268834-538.jpg'

                            ),
                          ),


                        ),
                      ),



                  ]
                  ),





                  const SizedBox(height: 7,),

                  Column(
                    children: [
                  LabelInputField(controller: nameController , label: AppLocalizations.of(context)!.name,  disable: true ),
                  LabelInputField(controller: ageController , label: AppLocalizations.of(context)!.age, disable: true),
                  LabelInputField(controller: genderController , label: AppLocalizations.of(context)!.gender, disable: true),
                  LabelInputField(controller: cityController , label: AppLocalizations.of(context)!.city, disable: true),
                  LabelInputField(controller: emailController , label: AppLocalizations.of(context)!.email),
                  LabelInputField(controller: phoneController, label: AppLocalizations.of(context)!.phone ),
                    ],
                  ),
                  Row(
                    children: [

                      // Expanded(flex: 1, child: Padding(
                      //   padding: const EdgeInsets.all(7.0),
                      //   child: Button(tap: (){}, text: 'Edit Profile', color: Colors.green, borderRadius: 10, fontColor: whiteColor, fontSize: 20,),
                      // )),
                      Expanded(flex: 1, child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Button(tap: (){

                          profileProvider.updateProfile(context, phoneController.text, emailController.text);
                          // Provider.of(context).updateProfile(context, phoneController.text, emailController.text);
                        }, text: AppLocalizations.of(context)!.save, color: primaryColor, borderRadius: 10, fontColor: whiteColor, fontSize: 20,),
                      )),
                    ],
                  )


                ],
              ),
            )
    )

          ),
        );


  }
}
