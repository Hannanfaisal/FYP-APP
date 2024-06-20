import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ur.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ur')
  ];

  /// No description provided for @helloWorld.
  ///
  /// In en, this message translates to:
  /// **'Hello World'**
  String get helloWorld;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @select_language.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get select_language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @urdu.
  ///
  /// In en, this message translates to:
  /// **'Urdu'**
  String get urdu;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeMode;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @agree_to_our_terms_conditions.
  ///
  /// In en, this message translates to:
  /// **'Agree to our terms & conditions'**
  String get agree_to_our_terms_conditions;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @please_sign_in_to_continue.
  ///
  /// In en, this message translates to:
  /// **'Please sign in to continue'**
  String get please_sign_in_to_continue;

  /// No description provided for @return_back.
  ///
  /// In en, this message translates to:
  /// **'Return back'**
  String get return_back;

  /// No description provided for @login_account.
  ///
  /// In en, this message translates to:
  /// **'Login Account'**
  String get login_account;

  /// No description provided for @login_officially.
  ///
  /// In en, this message translates to:
  /// **'Login Officially'**
  String get login_officially;

  /// No description provided for @officialMember.
  ///
  /// In en, this message translates to:
  /// **'Official Member?'**
  String get officialMember;

  /// No description provided for @enterCNIC.
  ///
  /// In en, this message translates to:
  /// **'Enter CNIC'**
  String get enterCNIC;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter Email'**
  String get enterEmail;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get enterPassword;

  /// No description provided for @enterMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter Massage'**
  String get enterMessage;

  /// No description provided for @enterSubject.
  ///
  /// In en, this message translates to:
  /// **'Enter Subject'**
  String get enterSubject;

  /// No description provided for @want_to_Logout.
  ///
  /// In en, this message translates to:
  /// **'Do you want to Logout?'**
  String get want_to_Logout;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @subject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subject;

  /// No description provided for @how_we_help_you.
  ///
  /// In en, this message translates to:
  /// **'How can we help you?'**
  String get how_we_help_you;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @verifyFace.
  ///
  /// In en, this message translates to:
  /// **'Verify Face'**
  String get verifyFace;

  /// No description provided for @news_updates.
  ///
  /// In en, this message translates to:
  /// **'News Updates'**
  String get news_updates;

  /// No description provided for @results.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get results;

  /// No description provided for @ratings.
  ///
  /// In en, this message translates to:
  /// **'Ratings'**
  String get ratings;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @rate_your_experience.
  ///
  /// In en, this message translates to:
  /// **'How much would you rate your experience so far?'**
  String get rate_your_experience;

  /// No description provided for @choose_star.
  ///
  /// In en, this message translates to:
  /// **'Choose stars to select your desired rating.'**
  String get choose_star;

  /// No description provided for @enter_feedback.
  ///
  /// In en, this message translates to:
  /// **'Enter your feedback here'**
  String get enter_feedback;

  /// No description provided for @feedback_required.
  ///
  /// In en, this message translates to:
  /// **'Feedback required*, It is compulsory \nto record your feedback'**
  String get feedback_required;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @register_candidate.
  ///
  /// In en, this message translates to:
  /// **'Register Candidate'**
  String get register_candidate;

  /// No description provided for @view_candidates.
  ///
  /// In en, this message translates to:
  /// **'View Candidates'**
  String get view_candidates;

  /// No description provided for @upcoming_events.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Events'**
  String get upcoming_events;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @change_password.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get change_password;

  /// No description provided for @create_new_password.
  ///
  /// In en, this message translates to:
  /// **'Create new Password'**
  String get create_new_password;

  /// No description provided for @unique_password.
  ///
  /// In en, this message translates to:
  /// **'Your new password must be unique from the previous one.'**
  String get unique_password;

  /// No description provided for @current_Password.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get current_Password;

  /// No description provided for @current_password_required.
  ///
  /// In en, this message translates to:
  /// **'Current password required*'**
  String get current_password_required;

  /// No description provided for @new_Password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_Password;

  /// No description provided for @new_password_required.
  ///
  /// In en, this message translates to:
  /// **'New password required*'**
  String get new_password_required;

  /// No description provided for @confirm_Password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_Password;

  /// No description provided for @confirm_password_required.
  ///
  /// In en, this message translates to:
  /// **'Confirm password required*'**
  String get confirm_password_required;

  /// No description provided for @password_characters.
  ///
  /// In en, this message translates to:
  /// **'Password must consists of 10 characters'**
  String get password_characters;

  /// No description provided for @password_not_matches.
  ///
  /// In en, this message translates to:
  /// **'Password does not matches'**
  String get password_not_matches;

  /// No description provided for @candidate_registration.
  ///
  /// In en, this message translates to:
  /// **'Candidate Registration'**
  String get candidate_registration;

  /// No description provided for @upload_image.
  ///
  /// In en, this message translates to:
  /// **'Upload Image'**
  String get upload_image;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @select_gender.
  ///
  /// In en, this message translates to:
  /// **'Select Gender'**
  String get select_gender;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'SAVE'**
  String get save;

  /// No description provided for @name_required.
  ///
  /// In en, this message translates to:
  /// **'Name field required*'**
  String get name_required;

  /// No description provided for @email_required.
  ///
  /// In en, this message translates to:
  /// **'Email field required*'**
  String get email_required;

  /// No description provided for @email_should_valid.
  ///
  /// In en, this message translates to:
  /// **'Email should be valid'**
  String get email_should_valid;

  /// No description provided for @gender_not_selected.
  ///
  /// In en, this message translates to:
  /// **'Gender not selected'**
  String get gender_not_selected;

  /// No description provided for @invalid_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get invalid_phone_number;

  /// No description provided for @phone_required.
  ///
  /// In en, this message translates to:
  /// **'Phone number required*'**
  String get phone_required;

  /// No description provided for @age_required.
  ///
  /// In en, this message translates to:
  /// **'Age field required*'**
  String get age_required;

  /// No description provided for @age_more_than_24.
  ///
  /// In en, this message translates to:
  /// **'Not eligible age should be more than 24'**
  String get age_more_than_24;

  /// No description provided for @age_less_than_70.
  ///
  /// In en, this message translates to:
  /// **'Not eligible age should be less than 70'**
  String get age_less_than_70;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @hi_welcome.
  ///
  /// In en, this message translates to:
  /// **'Hi! Welcome'**
  String get hi_welcome;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @elected_as.
  ///
  /// In en, this message translates to:
  /// **'Elected As'**
  String get elected_as;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @vote_recorded.
  ///
  /// In en, this message translates to:
  /// **'Vote Recorded!'**
  String get vote_recorded;

  /// No description provided for @thank_you.
  ///
  /// In en, this message translates to:
  /// **'Thank you for voting'**
  String get thank_you;

  /// No description provided for @digital_ballot.
  ///
  /// In en, this message translates to:
  /// **'Digital Ballot'**
  String get digital_ballot;

  /// No description provided for @seconds_left.
  ///
  /// In en, this message translates to:
  /// **'Seconds left:'**
  String get seconds_left;

  /// No description provided for @time_limit.
  ///
  /// In en, this message translates to:
  /// **'Cast vote with in below time limit'**
  String get time_limit;

  /// No description provided for @time_finished.
  ///
  /// In en, this message translates to:
  /// **'Time Finished'**
  String get time_finished;

  /// No description provided for @vote_time_finished.
  ///
  /// In en, this message translates to:
  /// **'Your voting time just finished'**
  String get vote_time_finished;

  /// No description provided for @go_back.
  ///
  /// In en, this message translates to:
  /// **'GO Back'**
  String get go_back;

  /// No description provided for @confirmation.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get confirmation;

  /// No description provided for @confirm_vote.
  ///
  /// In en, this message translates to:
  /// **'Do you want to confirm your vote?'**
  String get confirm_vote;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @announcements.
  ///
  /// In en, this message translates to:
  /// **'Announcements'**
  String get announcements;

  /// No description provided for @elections.
  ///
  /// In en, this message translates to:
  /// **'Elections'**
  String get elections;

  /// No description provided for @official_parties.
  ///
  /// In en, this message translates to:
  /// **'Official Parties'**
  String get official_parties;

  /// No description provided for @ongoing_events.
  ///
  /// In en, this message translates to:
  /// **'Ongoing Events'**
  String get ongoing_events;

  /// No description provided for @party_events.
  ///
  /// In en, this message translates to:
  /// **'Participated Events'**
  String get party_events;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ur'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ur': return AppLocalizationsUr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
