import 'package:flutter/material.dart';
import 'package:fyp/components/custom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fyp/view_model/theme_mode_provider.dart';
import 'package:provider/provider.dart';

class ThemeModeScreen extends StatefulWidget {
  const ThemeModeScreen({super.key});

  @override
  State<ThemeModeScreen> createState() => _ThemeModeScreenState();
}

class _ThemeModeScreenState extends State<ThemeModeScreen> {


  @override
  Widget build(BuildContext context) {

    final themeMode = Provider.of<ThemeModeProvider>(context);

    return Scaffold(
      appBar: customAppBar(title: AppLocalizations.of(context)!.themeMode,context: context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ListTile(

                leading: Radio(value: 1, groupValue:  themeMode.selected, onChanged: (val){
                  themeMode.changeThemeMode(ThemeMode.light,1);
                }),
                title:  Text(AppLocalizations.of(context)!.light, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
              ),
              const Divider(),
              ListTile(

                leading: Radio(value: 2, groupValue: themeMode.selected, onChanged: (val){
                  themeMode.changeThemeMode(ThemeMode.dark,2);
                }),
                title: Text(AppLocalizations.of(context)!.dark,style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
              ),
              const Divider()


            ],
          ),
        ),
      ),
    );
  }
}
