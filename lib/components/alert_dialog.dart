import 'package:flutter/material.dart';
import 'package:fyp/utils/app_colors.dart';

Future alertDialog({required context, dismissible = true ,required title, required content,required actions}){
  return showDialog(barrierDismissible: dismissible, context: context, builder: (context){
    return AlertDialog(title: Text(title),content: Text(content),actions: actions);
  });

}


