import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fyp/components/button.dart';
import 'package:fyp/components/custom_app_bar.dart';
import 'package:fyp/components/label_input_field.dart';
import 'package:fyp/utils/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterCandidateScreen extends StatefulWidget {
  const RegisterCandidateScreen({super.key});

  @override
  State<RegisterCandidateScreen> createState() =>
      _RegisterCandidateScreenState();
}

class _RegisterCandidateScreenState extends State<RegisterCandidateScreen> {

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController positionController = TextEditingController();

  String genderValue = '-1';

  File? image;
  String? base64Image;

  Future pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage == null) {
      return;
    }

    image = File(pickedImage.path);


    final bytes = await image!.readAsBytes();
    base64Image = base64Encode(bytes);

    setState(() {});
  }



  Future<void> registerCandidate() async {


    try {

     SharedPreferences sp = await SharedPreferences.getInstance();

     final id = sp.getString('_id');

      final response = await http.post(
          Uri.parse('http://192.168.100.26:5000/register-candidate'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'name': nameController.text.toString(),
            'email': emailController.text.toString(),
            'gender': genderValue,
            'age': ageController.text.toString(),
            'phone': phoneController.text.toString(),
            'position': 'position',
            'photo': base64Image,
            'party': id
          })

      );

      print(response.statusCode.toString());

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Candidate Registered'),
          backgroundColor: Colors.green,
        ));



        nameController.text='';
        emailController.text = '';
        phoneController.text = '';
        ageController.text = '';
        genderValue = '-1';

        image = null;
        setState(() {

        });

      } else {
        debugPrint(response.statusCode.toString());
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Candidate Registration failed'),
          backgroundColor: Colors.red,
        ));

      }





    }
    catch(e){
      debugPrint('Error Occurred $e');

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: AppLocalizations.of(context)!.register_candidate, context: context),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20.0),
            child: Material(
              borderRadius: BorderRadius.circular(10),
              elevation: 12,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Form(
                        key: formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.candidate_registration,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 85,
                                  height: 85,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: primaryColor, width: 2),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: image == null
                                        ? const Image(
                                            image: AssetImage(
                                                'assets/images/user.png'),
                                            fit: BoxFit.fill,
                                          )
                                        : Image.file(
                                            image!,
                                            fit: BoxFit.fill,
                                          ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                TextButton(
                                    onPressed: () {
                                      pickImage();
                                    },
                                    child:  Text(AppLocalizations.of(context)!.upload_image))
                              ],
                            ),
                          ),
                          LabelInputField(
                            controller: nameController,
                            label: AppLocalizations.of(context)!.name,
                            maxLines: 1,
                            icon: const Icon(Icons.person_rounded),
                            validator: (value){

                              if(value!.isEmpty){
                                return AppLocalizations.of(context)!.name_required;
                              }
                            },

                          ),
                          LabelInputField(
                              label: AppLocalizations.of(context)!.email,
                              controller: emailController,
                              maxLines: 1,
                              icon: const Icon(Icons.email_outlined),
                          validator: (value){
                                if(value!.isEmpty){
                                  return AppLocalizations.of(context)!.email_required;
                                }
                                if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                                  return AppLocalizations.of(context)!.email_should_valid;
                                }

                          },),

                          DropdownButtonFormField(
                              value: '-1',
                              onChanged: (val){
                                genderValue = val.toString();
                                setState(() {});
                              },
                            validator: (value) {
                              if(value == '-1'){
                               return AppLocalizations.of(context)!.gender_not_selected;
                              }

                            },
                              items: [
                                DropdownMenuItem(
                                  value: '-1',
                                  child: Text(
                                    AppLocalizations.of(context)!.select_gender,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'male',
                                  child: Text(AppLocalizations.of(context)!.male),
                                ),
                                DropdownMenuItem(
                                  value: 'female',
                                  child: Text(AppLocalizations.of(context)!.female),
                                )
                              ],

                              padding: const EdgeInsets.all(8),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: primaryColor),
                                    borderRadius: BorderRadius.circular(6)),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(6)),
                                contentPadding: const EdgeInsets.all(16.5),
                              ),
                              icon: const Icon(
                                  Icons.arrow_drop_down_circle_outlined),

                          ),
                          LabelInputField(
                              label: AppLocalizations.of(context)!.age,
                              controller: ageController,
                              maxLines: 1,
                              keyboardtype: TextInputType.number,
                              icon: const Icon(Icons.numbers),
                          validator: (value){
                                if(value!.isEmpty){
                                  return AppLocalizations.of(context)!.age_required;
                                }
                                if(int.parse(value) < 25){
                                  return AppLocalizations.of(context)!.age_more_than_24;
                                }
                                if(int.parse(value) > 70){
                                  return AppLocalizations.of(context)!.age_less_than_70;
                                }

                          },),
                          LabelInputField(
                              label: AppLocalizations.of(context)!.phone,
                              controller: phoneController,
                              maxLines: 1,
                              keyboardtype: TextInputType.phone,
                              icon: const Icon(Icons.phone),
                              validator: (value){
                                if(value!.isEmpty){
                                  return AppLocalizations.of(context)!.phone_required;
                                }
                                if(value!.length < 11 || value!.length > 12){
                                  return AppLocalizations.of(context)!.invalid_phone_number;
                                }
                              },),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Button(
                              tap: () {

                                if(nameController.text == '' || emailController.text == '' || phoneController.text == '' || ageController.text == '' || genderValue == '-1' || image == null ){
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter all fields"), backgroundColor: Colors.red,duration: Duration(seconds: 1),));
                                }else{
                                  registerCandidate();
                                }




                              },
                              text: AppLocalizations.of(context)!.register.toUpperCase(),
                              fontColor: Colors.white,
                              color: primaryColor,
                              borderRadius: 10,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
