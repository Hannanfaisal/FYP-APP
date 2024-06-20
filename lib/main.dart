
import 'package:flutter/material.dart';
import 'package:fyp/utils/app_colors.dart';
import 'package:fyp/view/home_screen.dart';
import 'package:fyp/view/internet_connectivity_screen.dart';
import 'package:fyp/view/login_screen.dart';
import 'package:fyp/view/official_view/official_home_screen.dart';
import 'package:fyp/view_model/announcement_provider.dart';
import 'package:fyp/view_model/auth_provider.dart';
import 'package:fyp/view_model/candidate_provider.dart';
import 'package:fyp/view_model/contact_provider.dart';
import 'package:fyp/view_model/contract_linking.dart';
import 'package:fyp/view_model/counter_provider.dart';
import 'package:fyp/view_model/election_provider.dart';
import 'package:fyp/view_model/feedback_provider.dart';
import 'package:fyp/view_model/language_provider.dart';
import 'package:fyp/view_model/political_parties_provider.dart';
import 'package:fyp/view_model/profile_provider.dart';
import 'package:fyp/view_model/theme_mode_provider.dart';
import 'package:fyp/view_model/vote_provider.dart';
import 'package:fyp/view_model/voter_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(

    statusBarColor: primaryColor, // status bar color
  ));

  SharedPreferences sp = await SharedPreferences.getInstance();
  String languageCode = sp.getString('language_code') ?? '';
  String themeMode = sp.getString('themeMode') ?? '';

  bool isLoggedIn = false;
  bool isOfficialLoggedIn = false;
  String token = sp.getString('token') ?? '';
  String officialToken = sp.getString('officialToken') ?? '';
  String officialId = sp.getString('_id') ?? '';
  print('Official token: ${officialToken}');
  print('Official Id: ${officialId}');
  var k = sp.containsKey('officialToken');
  print(k);

  if(officialToken != ''){
    isOfficialLoggedIn = true;
  }

  if(token != ''){
    isLoggedIn = true;
  }
  else{
    isLoggedIn = false;
  }



  runApp(MyApp(locale: languageCode,themeMode: themeMode, isLoggedIn: isLoggedIn,isOfficialLoggedIn: isOfficialLoggedIn));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.locale, required this.themeMode, required this.isLoggedIn, required this.isOfficialLoggedIn});

  final String locale;
  final String themeMode;
  final bool isLoggedIn;
  final bool isOfficialLoggedIn;


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> CounterProvider()),
      ChangeNotifierProvider(create: (_)=> ContractLinking()),
      ChangeNotifierProvider(create: (_)=> LanguageProvider()),
      ChangeNotifierProvider(create: (_)=> ThemeModeProvider()),
      ChangeNotifierProvider(create: (_)=> AnnouncementProvider()),
      ChangeNotifierProvider(create: (_)=> FeedbackProvider()),
      ChangeNotifierProvider(create: (_)=> ContactProvider()),
      ChangeNotifierProvider(create: (_)=> PoliticalPartiesProvider()),
      ChangeNotifierProvider(create: (_)=> AuthProvider()),
      ChangeNotifierProvider(create: (_)=> ElectionProvider()),
      ChangeNotifierProvider(create: (_)=> VoteProvider()),
      ChangeNotifierProvider(create: (_)=> CandidateProvider()),
      ChangeNotifierProvider(create: (_)=> ProfileProvider()),
      ChangeNotifierProvider(create: (_)=> VoterProvider())
    ],
    child: Consumer<LanguageProvider>(
      builder: (context,provider,child){
        if (provider.appLocale == null) {
          if (locale.isEmpty) {
            provider.changeLanguage( const Locale('en'));
          } else {
            provider.changeLanguage(Locale(locale));
          }
        }

        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'FYP',
            locale: locale == ' ' ? const Locale('en') : provider.appLocale == null ? Locale(locale): Provider.of<LanguageProvider>(context).appLocale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ur')
            ],
            theme: ThemeData(
                useMaterial3: true,
                brightness: Brightness.light,
                colorScheme: ColorScheme.fromSeed(seedColor:  primaryColor).copyWith(background: Colors.white)
            ),
            darkTheme: ThemeData(
                brightness: Brightness.dark
            ),
            themeMode: Provider.of<ThemeModeProvider>(context).themeMode  , //themeMode == '' ? Provider.of<ThemeModeProvider>(context).themeMode : themeMode == 'light' ? ThemeMode.light  : Provider.of<ThemeModeProvider>(context).themeMode ,
          home:

          InternetConnectivityWrapper (
            child: isLoggedIn
                ? const HomeScreen()
                : isOfficialLoggedIn
                ? const OfficialHomeScreen()
                : const LoginScreen(auth: true),
          ),

          //     () {
          //
          //   if (isLoggedIn == true) {
          //     return const HomeScreen();
          //   } else if ( isOfficialLoggedIn == true) {
          //     return const OfficialHomeScreen();
          //   } else {
          //     return const LoginScreen(auth: true,);
          //   }
          // }(),


        );
      },

    )
    );
  }
}
//  const LoginScreen(auth: true,)