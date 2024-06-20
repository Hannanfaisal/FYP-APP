import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fyp/components/button.dart';
import 'package:fyp/components/custom_app_bar.dart';
import 'package:fyp/components/label_input_field.dart';
import 'package:fyp/utils/app_colors.dart';
import 'package:fyp/view/official_view/profile.dart';
import 'package:fyp/view_model/political_parties_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class OfficialProfileScreen extends StatefulWidget {
  const OfficialProfileScreen(
      {super.key,
      required this.id,
      required this.name,
      required this.email,
      required this.description,
      required this.password,
      required this.image});

  final String? id;
  final String? name;
  final String? email;
  final String? description;
  final String? password;
  final String? image;

  @override
  State<OfficialProfileScreen> createState() => _OfficialProfileScreenState();
}

class _OfficialProfileScreenState extends State<OfficialProfileScreen> {
  File? image;
  File? coverImage;
  String? base64Image;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future pickImage(type) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage == null) {
      return;
    }

    image = File(pickedImage.path);
    final bytes = await image!.readAsBytes();
    base64Image = base64Encode(bytes);

    // switch(type){
    //   case 'profile_image':
    //     image = File(pickedImage.path);
    //   case 'cover_image':
    //     coverImage = File(pickedImage.path);
    // }

    setState(() {});
  }

  String base64String(File file) {
    List<int> fileBytes = file.readAsBytesSync();
    return base64Encode(fileBytes);
  }

  File _decodeBase64ToImage(String base64String) {
    Uint8List bytes = base64Decode(base64String);
    String tempPath = '${Directory.systemTemp.path}/temp_image.png';
    File imageFile = File(tempPath);
    imageFile.writeAsBytesSync(bytes);
    return imageFile;
  }

  File? profileImage;

  @override
  void initState() {
    nameController.text = widget.name.toString();
    emailController.text = widget.email.toString();
    descriptionController.text = widget.description.toString();
    passwordController.text = widget.password.toString();

    if (widget.image != null) {
      profileImage = _decodeBase64ToImage(widget.image!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final politicalPartyProvider =
        Provider.of<PoliticalPartiesProvider>(context);
    return Scaffold(
      appBar: customAppBar(title: 'Profile', context: context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              Center(
                child: SizedBox(
                  height: 120,
                  child: Stack(
                    children: [

                      Container(
                        width: 95,
                        height: 95,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: widget.image != null
                              ? Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: const Color(0XFFe6eaf2),
                                      border:
                                          Border.all(color: Colors.black26)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.file(
                                      profileImage!,
                                      fit: BoxFit.scaleDown,
                                    ), //display image here)) //Image( width: 6, image: AssetImage('assets/images/placeholder.png'),),
                                  ))
                              : Image.file(
                                  image!,
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          pickImage('profile_image');
                        },
                        child: CircleAvatar(
                          radius: 13,
                          backgroundColor: primaryColor,
                          child: const Icon(Icons.add),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0, right: 22),
                child: Material(
                  elevation: 12,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15),
                      child: Form(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabelInputField(
                            label: 'Name',
                            controller: nameController,
                            placeholder: 'Enter Name',
                            maxLines: 1,
                          ),
                          LabelInputField(
                            label: 'Email',
                            controller: emailController,
                            placeholder: 'Enter Email',
                            maxLines: 1,
                          ),
                          LabelInputField(
                            label: 'Description',
                            controller: descriptionController,
                            placeholder: 'Enter Description',
                            maxLines: 3,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Button(
                              tap: () {
//Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>Profile()), (route) => true);
//image: image != null ? base64Image! : base64String(profileImage!)
                                politicalPartyProvider.updateParty(
                                    context: context,
                                    name: nameController.value.text,
                                    email: emailController.value.text,
                                    description:
                                        descriptionController.value.text);
                              },
                              text: 'Save'.toUpperCase(),
                              color: primaryColor,
                              fontSize: 18,
                              fontColor: whiteColor,
                              borderRadius: 10,
                            ),
                          )
                        ],
                      )),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
