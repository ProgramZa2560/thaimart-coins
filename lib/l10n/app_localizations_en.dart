// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Thaimart Coins';

  @override
  String get searchHint => 'Search';

  @override
  String get noCoinsFound => 'No coins found';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get tryAgain => 'Try again';

  @override
  String get readMore => 'Read more';

  @override
  String get noDescription => 'No description';

  @override
  String get inviteFriends => 'Invite Friends';

  @override
  String get inviteSubtitle => 'Get bonus coins for each friend!';

  @override
  String get price => 'Price';

  @override
  String get marketCap => 'Market Cap';

  @override
  String get selectCoinPrompt => 'Select a coin to see details';

  @override
  String get loading => 'Loading';
}
