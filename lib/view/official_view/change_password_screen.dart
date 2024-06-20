

import 'package:flutter/material.dart';
import 'package:fyp/components/button.dart';
import 'package:fyp/components/custom_app_bar.dart';
import 'package:fyp/components/label_input_field.dart';
import 'package:fyp/utils/app_colors.dart';
import 'package:fyp/view_model/political_parties_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final politicalPartyProvider = Provider.of<PoliticalPartiesProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(context: context,title: 'Change Password'),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 0),
                child: Text(AppLocalizations.of(context)!.create_new_password, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),),
              ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Text(AppLocalizations.of(context)!.unique_password, style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black54, fontSize: 15),),
            ),

              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,

                    child:

                    Column(
                      children: [
                        LabelInputField(label: AppLocalizations.of(context)!.current_Password, controller: currentPasswordController, validator: (value){
                          if(value!.isEmpty){
                            return AppLocalizations.of(context)!.current_password_required;
                          }
                          if(value!.length < 10){
                           return AppLocalizations.of(context)!.password_characters;
                         }


                          return null;
                        },),

                        LabelInputField(label: AppLocalizations.of(context)!.new_Password, controller: newPasswordController, validator: (value){
                          if(value!.isEmpty){
                            return AppLocalizations.of(context)!.new_password_required;
                          }
                          if(value!.length < 10){
                            return AppLocalizations.of(context)!.password_characters;
                          }

                          return null;
                        },),

                        LabelInputField(label: AppLocalizations.of(context)!.confirm_Password, controller: confirmPasswordController, validator: (value){
                          if(value!.isEmpty){
                            return AppLocalizations.of(context)!.confirm_password_required;
                          }
                          if(value!.length < 10){
                            return AppLocalizations.of(context)!.password_characters;
                          }
                          if(value! != newPasswordController.text){
                            return AppLocalizations.of(context)!.password_not_matches;
                          }

                          return null;
                        },),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 10.0),
                          child: Button(tap: (){
                            if(_formKey.currentState!.validate()){
                              politicalPartyProvider.changePassword(context, '6624ae40edb2331c1f29bea7', currentPasswordController.text, newPasswordController.text);
                            }
                          }, text: AppLocalizations.of(context)!.change_password, color: primaryColor, fontSize: 18, borderRadius: 8,),
                        )
                      ],
                    )
                ),
              )

          ],
        ),
      )),
    );
  }
}
